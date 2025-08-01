class_name GameOverUI
extends Control

signal onRestartGame();

@export var _anim: AnimationPlayer;
@export var _dialogBox: DialogBox;
@export var _finalScore: Label;
@export var _replayButton: Button;
@export var _finalStats: Control;


var _isStarted := false;


var dialogItems := {
  "intro": "I thought I asked you to have this room cleaned by the time I got home...",
  "good": "I want to be mad, but you're just such a cute little guy! Do you like video games?",
  "bad": "What are you staring at, little guy? Get to work!",
  "secret": "Oh! Thanks for staying clean in here! Aww, aren't you a cute little guy!"
};


func _ready():
  _anim.animation_finished.connect(handleAnimFinished);
  _dialogBox.finished.connect(handleDialogFinished);
  _replayButton.pressed.connect(restartGame);
  _finalStats.hide();


func restartGame():
  onRestartGame.emit();


func startGameOverSequence():
  if (_isStarted): return;
  Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
  print("starting game over sequence");
  _isStarted = true;
  _finalStats.hide();
  show();
  _anim.play("game-over-intro");


func handleAnimFinished(anim_name: StringName):
  print("anim finished: " + anim_name);
  if (anim_name == "game-over-intro"):
    print("revealing intro text");
    _dialogBox.revealText(dialogItems["intro"]);


func handleDialogFinished(text: String):
  print("dialog finished: " + text);
  if (text == dialogItems["intro"]):
    if (GameStateManager.didWin):
      _dialogBox.revealText(dialogItems["good"]);
    elif (GameStateManager.gameState.points == 0):
      _dialogBox.revealText(dialogItems["secret"]);
    else:
      _dialogBox.revealText(dialogItems["bad"]);
  else:
    _finalScore.text = "Final Score: %d" % GameStateManager.gameState.points;
    _finalStats.show();