class_name Game
extends Node

@export var _mainMenu: MainMenu;
@export var _gameOverUI: GameOverUI;
@export var _gameWorld: GameWorld;


var _isGameOver := false;


func _ready():
  _mainMenu.start_game.connect(startGame);
  _gameOverUI.onRestartGame.connect(startGame);
  GameStateManager.game_state_changed.connect(handleGameStateChanged);
  get_tree().paused = true;


func startGame():
  _mainMenu.hide();
  _gameOverUI.hide();
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
  GameStateManager.reinitialize();
  get_tree().paused = false;
  # TODO: Reinitialize room.


func handleGameStateChanged(state: GameState):
  if (GameStateManager.isGameOver && !_isGameOver):
    _isGameOver = true;
    GameStateManager.applyCurrentCombo();
    get_tree().paused = true;
    _gameOverUI.startGameOverSequence();
    # TODO: freeze game world?