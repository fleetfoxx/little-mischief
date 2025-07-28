class_name PlayerBody
extends CharacterBody3D

@export_category("Movement")
@export var _mouseSensitivity := 10;
@export var _walkSpeed := 10;
@export var _walkAcceleration := 100;
@export var _jumpHeight := 1;
@export var _pushForce := 500;
@export var _punchForce := 500;

@export var _camera: Camera3D;

@export_category("Holdin' & Grabbin'")
@export var _holdPoint: Marker3D;
@export var _selectionRay: RayCast3D;
var _heldObject: Node3D = null;
var _heldObjectPreviousParent: Node3D = null;

var _isJumping := false;
var _lookDirection := Vector2.ZERO;
var _moveDirection := Vector2.ZERO;
var _walkVelocity := Vector3.ZERO;
var _gravityVelocity := Vector3.ZERO;
var _jumpVelocity := Vector3.ZERO;
var _impulse := Vector3.ZERO;

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity");

func _ready():
  pass ;


func _unhandled_input(event: InputEvent):
  if (event is InputEventMouseMotion):
    _lookDirection = event.relative * 0.001;

    if (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
      rotateCamera();

  if (Input.is_action_just_pressed("jump")):
    _isJumping = true;

  tryDropObject(event);
  tryGrabObject(event);
  tryPunchObject(event);


func _physics_process(delta):
  velocity = walk(delta) + gravity(delta) + jump(delta)
  var collided = move_and_slide();

  if (collided):
    for i in range(get_slide_collision_count()):
      var collision = get_slide_collision(i);
      if (collision.get_collider() is RigidBody3D):
        (collision.get_collider() as RigidBody3D).apply_force(collision.get_normal() * -_pushForce);


func tryDropObject(event: InputEvent):
  if (!event.is_action_released("action-right")): return ;
  if (_heldObject == null): return ;

  print("dropping %s" % _heldObject.name);

  var prevPos = _heldObject.global_position;
  _holdPoint.remove_child(_heldObject);
  _heldObjectPreviousParent.add_child(_heldObject);
  _heldObject.global_position = prevPos;

  if (_heldObject is RigidBody3D):
    # enable player collision
    _heldObject.set_collision_mask_value(2, true);
    _heldObject.freeze = false;

  if (_heldObject.has_method("drop")):
    _heldObject.drop();
  _heldObject = null;


func tryGrabObject(event: InputEvent):
  if (!event.is_action_pressed("action-right")): return ;
  if (_heldObject != null): return ;

  # check if selection ray is intersecting
  var collision = _selectionRay.get_collider();

  # nothing to grab
  if (collision == null): return ;

  print("grabbing %s" % collision.name);

  _heldObject = collision;
  _heldObjectPreviousParent = _heldObject.get_parent();
  _heldObjectPreviousParent.remove_child(_heldObject);

  if (_heldObject is RigidBody3D):
    # disable player collision
    _heldObject.set_collision_mask_value(2, false);
    _heldObject.freeze = true;
    # TODO: disable

  if (_heldObject.has_method("grab")):
    _heldObject.grab();

  _holdPoint.add_child(_heldObject);
  _heldObject.position = Vector3.ZERO;


func tryPunchObject(event: InputEvent):
  if (!event.is_action_pressed("action-left")): return ;
  var collision = _selectionRay.get_collider();
  if (collision == null):
    tryPunchHeldObject(event);
  else:
    print("punching %s" % collision.name);
    if (collision is RigidBody3D):
      var normal = _selectionRay.get_collision_normal();
      collision.apply_force(normal * -_punchForce);
    if (collision.has_method("punch")):
      collision.punch();


func tryPunchHeldObject(event: InputEvent):
  if (!event.is_action_pressed("action-left")): return ;
  if (_heldObject == null): return ;
  if (_heldObject.has_method("punch")):
    _heldObject.punch();


func rotateCamera():
  var y = _camera.rotation.y - _lookDirection.x * _mouseSensitivity;
  var x = clampf(_camera.rotation.x - _lookDirection.y * _mouseSensitivity, -1.5, 1.5);
  _camera.rotation = Vector3(x, y, _camera.rotation.z);


func walk(delta: float):
  _moveDirection = Input.get_vector("move-left", "move-right", "move-forward", "move-back");
  var forward = _camera.global_transform.basis * Vector3(_moveDirection.x, 0, _moveDirection.y);
  var walkDirection = Vector3(forward.x, 0, forward.z).normalized();
  var speed = _walkSpeed;
  var target = walkDirection * _moveDirection.length() * speed;
  _walkVelocity = _walkVelocity.move_toward(target, _walkAcceleration * delta);
  return _walkVelocity;


func gravity(delta: float):
  var gravity = _gravity;
  _gravityVelocity = Vector3.ZERO if is_on_floor() else _gravityVelocity.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta);
  return _gravityVelocity;


func jump(delta: float):
  if (_isJumping):
    if (is_on_floor()):
      _jumpVelocity = Vector3(0, sqrt(4 * _jumpHeight * _gravity), 0);
    _isJumping = false;
    return _jumpVelocity;
  _jumpVelocity = Vector3.ZERO if is_on_floor() else _jumpVelocity.move_toward(Vector3.ZERO, _gravity * delta);
  return _jumpVelocity;