class_name DisplaceableObject
extends RigidBody3D

@export var _pointsOnDisplace := 1;
@export var _displacementDeadzone := 0.0;

var _initialPosition := Vector3.ZERO;
var _isDisplaced := false;
var _isSettled := false;
var _sourceName := "Object";


func _ready():
  sleeping_state_changed.connect(sleepingStateChanged);


func _process(delta):
  if (!_isDisplaced && !sleeping && _isSettled):
    if (global_position.distance_squared_to(_initialPosition) >= (_displacementDeadzone * _displacementDeadzone)):
      displace();


func sleepingStateChanged():
  if (_isDisplaced): return ;
  if (!sleeping): return ;
  _initialPosition = global_position;
  _isSettled = true;
  # print("%s has settled, initial position set to %s" % [name, _initialPosition]);


func displace():
  print("displaced! adding %d points" % _pointsOnDisplace);
  _isDisplaced = true;
  GameStateManager.addPoints(_pointsOnDisplace, _sourceName);


func grab():
  freeze = true;


func drop():
  freeze = false;