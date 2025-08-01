extends StaticBody3D

@export var _remote: TVRemote;
@export var _screenMesh: MeshInstance3D;

var _isOn := false;
var _firstTrigger := false;

func _ready():
  _remote.pressed.connect(toggleScreen);
  turnOn();


func toggleScreen():
  if (_isOn):
    turnOff();
  else:
    turnOn();


func turnOn():
  if (_isOn): return;
  _isOn = true;
  setScreenColor(Color.GREEN);


func turnOff():
  if (!_isOn): return;
  _isOn = false;
  setScreenColor(Color.BLACK);
  if (!_firstTrigger):
    _firstTrigger = true;
    GameStateManager.addPoints(25, "Turn the TV off");


func setScreenColor(color: Color):
  var mesh: QuadMesh = _screenMesh.mesh;
  var mat: StandardMaterial3D = mesh.material.duplicate();
  mat.albedo_color = color;
  mesh.material = mat;