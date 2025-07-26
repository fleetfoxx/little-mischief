extends Node

signal game_state_changed(state: GameState);

# TODO: convert this to a custom class. accessing properties by string name is fragile
var _gameState := GameState.new(0);

func _ready():
  await get_tree().process_frame;
  game_state_changed.emit(_gameState);

func addPoints(amt: int):
  _gameState.set("points", _gameState.get("points") + amt);
  game_state_changed.emit(_gameState);