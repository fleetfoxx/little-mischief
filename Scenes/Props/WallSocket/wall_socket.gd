extends Area3D

@export var _sparkArea: Area3D;
@export var _sparkParticles: GPUParticles3D;

@export var _pointsOnWet := 25;


var _isWet := false;


func _ready():
  _sparkArea.monitoring = false;
  _sparkArea.monitorable = false;
  _sparkParticles.emitting = false;
  area_entered.connect(handleWaterContact);


func handleWaterContact(area: Area3D):
  if (_isWet): return ;
  _sparkArea.monitoring = true;
  _sparkArea.set_deferred("monitorable", true);
  _sparkParticles.emitting = true;
  _isWet = true;
  GameStateManager.addPoints(_pointsOnWet, "Wall Socket");