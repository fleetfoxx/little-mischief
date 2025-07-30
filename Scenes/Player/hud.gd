extends Control

@export var _pointsLabel: Label;
@export var _chainLabel: Label;
@export var _chainMultLabel: Label;
@export var _countdownLabel: Label;

var _updateTimer: Timer;

func _ready():
  GameStateManager.game_state_changed.connect(handleGameStateChanged);
  _updateTimer = Timer.new();
  add_child(_updateTimer);
  _updateTimer.timeout.connect(updateHUD);
  _updateTimer.start(1);


func sum(acc: int, val: PointsEvent):
  return acc + val.points;


func selectSource(event: PointsEvent):
  return event.source;


func handleGameStateChanged(state: GameState):
  _pointsLabel.text = str(state.points);
  var mult := state.currentChain.size();
  if (mult == 0):
    _chainLabel.text = "";
    _chainMultLabel.text = "";
  else:
    var total = state.currentChain.reduce(sum, 0);
    var chain := " + ".join(state.currentChain.map(selectSource));
    _chainLabel.text = chain;
    _chainMultLabel.text = "%d x %d" % [total, mult];

  # Update countdown
  updateHUD();

  
func updateHUD():
  var currentTime := Time.get_unix_time_from_system();
  var diff := GameStateManager.gameState.secondsUntilMomArrives - (currentTime - GameStateManager.gameState.startTimeStamp);
  if (diff < 0):
    _countdownLabel.text = "00:00";
  else:
    var minutes := floor(diff / 60) as int;
    var seconds := floor(diff) as int % 60;
    _countdownLabel.text = "%02d:%02d" % [minutes, seconds];