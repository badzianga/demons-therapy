class_name HUD
extends CanvasLayer

@onready var time_label := $TimeLabel


# called in game controller
func set_time(hour: int, minute: int) -> void:
	var minute_string: String
	if minute < 10:
		minute_string = "0" + str(minute) 
	else:
		minute_string = str(minute)
	time_label.text = str(hour) + ":" + minute_string
