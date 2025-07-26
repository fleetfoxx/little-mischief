extends Node3D

@export var _player: PlayerBody;
@export var _spawn: Marker3D;

func _ready():
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
  teleportPlayerToSpawn();

func _unhandled_input(event):
  if (event.is_action_pressed("respawn")):
    teleportPlayerToSpawn();

func teleportPlayerToSpawn():
  _player.global_position = _spawn.global_position;
  _player.global_rotation = _spawn.global_rotation;
