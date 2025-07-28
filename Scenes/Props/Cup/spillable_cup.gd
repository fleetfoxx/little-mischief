extends DisplaceableObject

@export var _waterParticles: GPUParticles3D;

func grab():
  _waterParticles.emitting = true;


func drop():
  _waterParticles.emitting = false;


func punch():
  _waterParticles.emitting = true;
  await get_tree().create_timer(1).timeout;
  _waterParticles.emitting = false;