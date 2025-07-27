extends Control

@export var _leftHand: TextureRect;
@export var _rightHand: TextureRect;

@export var _defaultSprite: Texture2D;
@export var _punchSprite: Texture2D;

func _unhandled_input(event):
  if (event.is_action_pressed("action-left")):
    _leftHand.texture = _punchSprite;
  elif (event.is_action_released("action-left")):
    _leftHand.texture = _defaultSprite;

  if (event.is_action_pressed("action-right")):
    _rightHand.texture = _punchSprite;
  elif (event.is_action_released("action-right")):
    _rightHand.texture = _defaultSprite;