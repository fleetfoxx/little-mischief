class_name TVRemote
extends RigidBody3D

signal pressed();

func punch():
  pressed.emit();