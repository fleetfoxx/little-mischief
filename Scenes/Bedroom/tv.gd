extends StaticBody3D

@export var _remote: TVRemote;
@export var _screenMesh: MeshInstance3D;

var _isOn := false;

func _ready():
  _remote.pressed.connect(toggleScreen);


func toggleScreen():
  _isOn = !_isOn;
  if (_isOn):
    setScreenColor(Color.GREEN);
  else:
    setScreenColor(Color.BLACK);


func setScreenColor(color: Color):
  var mesh: QuadMesh = _screenMesh.mesh;
  var mat: StandardMaterial3D = mesh.material.duplicate();
  mat.albedo_color = color;
  mesh.material = mat;