class_name DialogBox
extends Control

signal finished(text: String);

@export var _text: Label;
@export var _revealSpeed := 0.1;
@export var _continueIndicator: TextureRect;

var _isRevealing := false;

func _ready():
  _continueIndicator.hide();


func _process(delta):
  if (_isRevealing):
    _text.visible_ratio += _revealSpeed * delta;
    if (_text.visible_ratio >= 1.0):
      _isRevealing = false;
      _continueIndicator.show();


func _unhandled_input(event):
  if (event.is_action_pressed("progress-dialog")):
    if (_isRevealing):
      _text.visible_ratio = 1.0;
    else:
      finished.emit(_text.text);


func revealText(text: String):
  show();
  _text.text = text;
  _text.visible_ratio = 0;
  _isRevealing = true;
  _continueIndicator.hide();
