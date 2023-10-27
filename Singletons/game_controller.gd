extends Node

#const LEVEL_TIMES: Array[int] = [60]
const LEVEL_TIMES: Array[int] = [0, 10]

var level_time := 0

@onready var timer := $Timer


func start_level(level: int) -> void:
	level_time = LEVEL_TIMES[level]
	timer.start()


func _on_level_timer_timeout() -> void:
	level_time -= 1
	if level_time <= 0:
		pass
