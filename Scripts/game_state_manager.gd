extends Node

signal game_state_changed(state: GameState);

var gameState := GameState.new();

var _gameOverTimer: Timer;
var _chainTimer: Timer;
var _timeToCombo := 3;

# var secondsUntilMomArrives := 60 * 5; # 5 min
var secondsUntilMomArrives := 10; # for testing
var pointsToWin := 500;
var didWin: bool:
  get:
    return gameState.points >= pointsToWin;


var isGameOver : bool:
  get:
    var current = Time.get_unix_time_from_system();
    return gameState.startTimeStamp + secondsUntilMomArrives <= current;


func _ready():
  _chainTimer = Timer.new();
  add_child(_chainTimer);
  _chainTimer.timeout.connect(onChainTimeout);

  _gameOverTimer = Timer.new();
  add_child(_gameOverTimer);
  _gameOverTimer.timeout.connect(onGameOverTimerElapsed);

  await get_tree().process_frame;
  reinitialize();


func reinitialize():
  gameState = GameState.new();
  gameState.startTimeStamp = Time.get_unix_time_from_system(); # TODO: ensure this isn't called until the game starts. perhaps this logic belongs in the GameWorld scene?
  gameState.secondsUntilMomArrives = secondsUntilMomArrives;
  game_state_changed.emit(gameState);
  _gameOverTimer.start(1);


func addPoints(amt: int, source: String):
  # gameState.set("points", gameState.get("points") + amt);
  gameState.currentChain.append(PointsEvent.new(amt, source));
  game_state_changed.emit(gameState);
  _chainTimer.start(_timeToCombo);


func sum(acc: int, val: PointsEvent):
  return acc + val.points;


func onChainTimeout():
  var chainTotal = gameState.currentChain.reduce(sum, 0) * gameState.currentChain.size();
  gameState.set("points", gameState.get("points") + chainTotal);
  gameState.currentChain = [];
  game_state_changed.emit(gameState);


func onGameOverTimerElapsed():
  if (isGameOver):
    game_state_changed.emit(gameState);