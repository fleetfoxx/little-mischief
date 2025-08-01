extends StaticBody3D

@export var _ballDetector: Area3D;

var _scored := false;

func _ready():
  _ballDetector.body_entered.connect(handleBallDetected);


func handleBallDetected(body: Node3D):
  if (_scored): return;
  _scored = true;
  GameStateManager.addPoints(25, "Swish");