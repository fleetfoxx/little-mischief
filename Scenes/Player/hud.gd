extends Control

@export var _pointsLabel: Label;
@export var _chainLabel: Label;
@export var _chainMultLabel: Label;


func _ready():
  GameStateManager.game_state_changed.connect(handleGameStateChanged);


func sum(acc: int, val: PointsEvent):
  return acc + val.points;


func selectSource(event: PointsEvent):
  return event.source;


func handleGameStateChanged(state: GameState):
  _pointsLabel.text = str(state.points);
  var mult = state.currentChain.size();
  if (mult == 0):
    _chainLabel.text = "";
    _chainMultLabel.text = "";
  else:
    var total = state.currentChain.reduce(sum, 0);
    var chain = " + ".join(state.currentChain.map(selectSource));
    _chainLabel.text = chain;
    _chainMultLabel.text = "%d x %d" % [total, mult];