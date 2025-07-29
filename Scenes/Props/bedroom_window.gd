extends Area3D

@export var _fireParticles: GPUParticles3D;
@export var _smokeParticles: GPUParticles3D;
@export var _fireArea: Area3D;

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


func ignite(area: Area3D):
  if (_isLit): return ;
  monitoring = false;
  monitorable = false;
  _fireParticles.emitting = true;
  _smokeParticles.emitting = true;
  _fireArea.monitoring = true;
  _fireArea.monitorable = true;
  _isLit = true;
  GameStateManager.addPoints(_pointsOnBurn, "Crispy Curtains");