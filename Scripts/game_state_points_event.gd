class_name PointsEvent

var points: int;
var timestamp: float;
var source: String;

func _init(_points: int):
  points = _points;
  timestamp = Time.get_unix_time_from_system();
  source = "TODO";
