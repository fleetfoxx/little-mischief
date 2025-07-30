class_name Game
extends Node

@export var _mainMenu: MainMenu;
@export var _gameOverUI: GameOverUI;


func _ready():
  _mainMenu.start_game.connect(startGame);
  _gameOverUI.onRestartGame.connect(startGame);
  GameStateManager.game_state_changed.connect(handleGameStateChanged);


func startGame():
  _mainMenu.hide();
  _gameOverUI.hide();
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
  GameStateManager.reinitialize();
  # TODO: Reinitialize room.


func handleGameStateChanged(state: GameState):
  if (GameStateManager.isGameOver):
    _gameOverUI.startGameOverSequence();
    # TODO: freeze game world?