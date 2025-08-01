extends Area3D

@export var _fireParticles: GPUParticles3D;
@export var _smokeParticles: GPUParticles3D;
@export var _fireArea: Area3D;
@export var _fireSFX: AudioStreamPlayer3D;

@export var _pointsOnBurn := 50;


var _isLit := false;


func _ready():
  area_entered.connect(ignite);
  monitoring = true;
  monitorable = true;
  _fireArea.monitoring = false;
  _fireArea.monitorable = false;
  _fireParticles.emitting = false;
  _smokeParticles.emitting = false;
  _fireSFX.stop();


func ignite(area: Area3D):
  if (_isLit): return ;
  set_deferred("monitoring", false);
  set_deferred("monitorable", false);
  _fireParticles.emitting = true;
  _smokeParticles.emitting = true;
  _fireArea.set_deferred("monitoring", true);
  _fireArea.set_deferred("monitorable", true);
  _isLit = true;
  GameStateManager.addPoints(_pointsOnBurn, "Crispy Curtains");
  _fireSFX.play();