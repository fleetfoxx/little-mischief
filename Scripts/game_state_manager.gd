extends Node

signal game_state_changed(state: GameState);

var gameState := GameState.new();

var _tickTimer: Timer;
var _chainTimer: Timer;
var _secondsToCombo := 5;

var secondsUntilMomArrives := 60 * 1; # 1 min
# var secondsUntilMomArrives := 10; # for testing
var pointsToWin := 1000;

var didWin: bool:
  get:
    return gameState.points >= pointsToWin;

var isGameOver: bool:
  get:
    return gameState.elapsedSeconds >= secondsUntilMomArrives;


func _ready():
  _chainTimer = Timer.new();
  add_child(_chainTimer);
  _chainTimer.timeout.connect(onChainTimeout);

  _tickTimer = Timer.new();
  add_child(_tickTimer);
  _tickTimer.timeout.connect(onTickTimerElapsed);

  await get_tree().process_frame;
  reinitialize();


func reinitialize():
  gameState = GameState.new();
  gameState.secondsUntilMomArrives = secondsUntilMomArrives;
  game_state_changed.emit(gameState);
  _tickTimer.start(1);


func addPoints(amt: int, source: String):
  gameState.currentChain.append(PointsEvent.new(amt, source));
  game_state_changed.emit(gameState);
  _chainTimer.start(_secondsToCombo);


func applyCurrentCombo():
  var chainTotal := gameState.currentChain.reduce(sum, 0) as int * gameState.currentChain.size();
  gameState.points += chainTotal;
  gameState.currentChain = [];
  game_state_changed.emit(gameState);


func sum(acc: int, val: PointsEvent):
  return acc + val.points;


func onChainTimeout():
  applyCurrentCombo();


func onTickTimerElapsed():
  gameState.elapsedSeconds += 1;
  game_state_changed.emit(gameState);