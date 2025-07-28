extends Node

signal game_state_changed(state: GameState);


var _gameState := GameState.new();
var _timeToCombo := 3;
var _chainTimer: Timer;


func _ready():
  _chainTimer = Timer.new();
  add_child(_chainTimer);
  _chainTimer.timeout.connect(onChainTimeout);
  await get_tree().process_frame;
  game_state_changed.emit(_gameState);


func addPoints(amt: int):
  # _gameState.set("points", _gameState.get("points") + amt);
  _gameState.currentChain.append(PointsEvent.new(amt));
  game_state_changed.emit(_gameState);
  _chainTimer.start(_timeToCombo);


func sum(acc: int, val: PointsEvent):
  return acc + val.points;


func onChainTimeout():
  var chainTotal = _gameState.currentChain.reduce(sum, 0) * _gameState.currentChain.size();
  _gameState.set("points", _gameState.get("points") + chainTotal);
  _gameState.currentChain = [];
  game_state_changed.emit(_gameState);