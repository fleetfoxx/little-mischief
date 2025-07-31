class_name PauseMenu
extends Control

@export var _resumeButton: Button;

func _ready():
  _resumeButton.pressed.connect(resume);
  hide();


func _unhandled_input(event):
  if (event.is_action_pressed("toggle-pause")):
    toggle();


func toggle():
  if (visible):
    resume();
  else:
    pause();


func pause():
  Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
  get_tree().paused = true;
  show();


func resume():
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
  get_tree().paused = false;
  hide();