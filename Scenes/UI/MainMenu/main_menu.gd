class_name MainMenu
extends Control

signal start_game();

@export var _startButton: TextureButton;

func _ready():
  _startButton.pressed.connect(emitStartGame);

func emitStartGame():
  start_game.emit();
