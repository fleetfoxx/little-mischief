extends Control

@export var _leftHand: TextureRect;
@export var _rightHand: TextureRect;
@export var _anim: AnimationPlayer;

@export var _defaultSprite: Texture2D;
@export var _punchSprite: Texture2D;


func _ready():
  _anim.animation_finished.connect(animationFinished);


func _unhandled_input(event):
  if (event.is_action_pressed("action-left")):
    startPunch();
  if (event.is_action_pressed("action-right")):
    _rightHand.texture = _punchSprite;
  elif (event.is_action_released("action-right")):
    _rightHand.texture = _defaultSprite;


func startPunch():
  _leftHand.texture = _punchSprite;
  _anim.play("punch");


func animationFinished(anim_name: StringName):
  if (anim_name == "punch"):
    _leftHand.texture = _defaultSprite;