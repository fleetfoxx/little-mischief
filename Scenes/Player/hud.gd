extends Control

@export var _pointsLabel: Label;

func _ready():
  GameStateManager.game_state_changed.connect(handleGameStateChanged);

func handleGameStateChanged(state: GameState):
  _pointsLabel.text = str(state.points);