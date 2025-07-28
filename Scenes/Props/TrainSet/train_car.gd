class_name TrainCar
extends RigidBody3D

signal crashed

@export var _crashDetector: Area3D;

func _ready():
  _crashDetector.body_entered.connect(bodyEntered);
  freeze = true;


func bodyEntered(body: Node3D):
  if (body == self): return;
  print("crashed into %s" % body.name);
  crashed.emit();


func grab():
  crashed.emit();
