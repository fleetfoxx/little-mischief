extends RigidBody3D

@export var _bounceSFX: AudioStreamPlayer3D;

func _ready():
  body_entered.connect(handleBodyEntered);


func handleBodyEntered(body: Node):
  _bounceSFX.play();