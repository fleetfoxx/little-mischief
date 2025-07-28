class_name TrainCar
extends RigidBody3D

signal crashed

@export var _crashDetector: Area3D;

var _crashed := false;


func _ready():
  _crashDetector.body_entered.connect(bodyEntered);
  freeze = true;


func bodyEntered(body: Node3D):
  if (body == self): return ;
  if (_crashed): return ;
  print("crashed into %s" % body.name);
  crashed.emit();
  _crashed = true;


func grab():
  if (!_crashed):
    crashed.emit();
