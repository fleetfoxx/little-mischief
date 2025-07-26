class_name DisplaceableObject
extends RigidBody3D

@export var _pointsOnDisplace := 1;

var _initialPosition := Vector3.ZERO;
var _isDisplaced := false;

func _ready():
  sleeping_state_changed.connect(sleepingStateChanged);

func sleepingStateChanged():
  # This item has already been displace, we don't care about any more state changes.
  if (_isDisplaced): return ;

  if (!sleeping):
    displace();
  else:
    # This should only happen after the object has settled for the first time.
    _initialPosition = global_position;
    # print("%s has settled for the first time, initial position set to %s" % [name, _initialPosition]);

func displace():
  print("displaced! adding %d points" % _pointsOnDisplace);
  _isDisplaced = true;
  GameStateManager.addPoints(_pointsOnDisplace);