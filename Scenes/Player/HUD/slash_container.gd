extends Control

@export var _slashes: Array[TextureRect];


func _ready():
  GameStateManager.game_state_changed.connect(handleGameStateChanged);


func handleGameStateChanged(state: GameState):
  for i in range(_slashes.size()):
    _slashes[i].visible = (i + 1) * 100 <= state.points;