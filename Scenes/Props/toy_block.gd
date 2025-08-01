extends DisplaceableObject

@export var _knockSFX: AudioStreamPlayer3D;


func _ready():
  super();
  _sourceName = "Block";
  body_entered.connect(handleBodyEntered);


func grab():
  _knockSFX.play();


func handleBodyEntered(body: Node):
  _knockSFX.play();