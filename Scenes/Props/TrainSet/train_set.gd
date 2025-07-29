extends Node3D

@export var _pathFollow: PathFollow3D;
@export var _speed := 1.0;

@export var _trainCar: TrainCar;
@export var _pointsPerCrash := 20;

var _crashed := false;

func _ready():
  _trainCar.crashed.connect(handleCrashed);

func _process(delta):
  if (!_crashed):
    _pathFollow.progress_ratio += _speed * delta;

func handleCrashed():
  if (_crashed): return ;
  print("Crashed!");
  _crashed = true;
  GameStateManager.addPoints(_pointsPerCrash, "Derailed");
