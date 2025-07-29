class_name PointsEvent

var points: int;
var timestamp: float;
var source: String;

func _init(_points: int, _source: String):
  points = _points;
  timestamp = Time.get_unix_time_from_system();
  source = _source;
