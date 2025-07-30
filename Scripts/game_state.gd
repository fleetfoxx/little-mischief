class_name GameState

var points := 0;
var currentChain: Array[PointsEvent] = [];
var startTimeStamp: float; # Time.get_unix_time_from_system()
var secondsUntilMomArrives: int;