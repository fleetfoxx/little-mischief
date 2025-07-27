class_name Game
extends Node

@export var _mainMenu: MainMenu;

func _ready():
  _mainMenu.start_game.connect(startGame);

func startGame():
  _mainMenu.hide();
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
