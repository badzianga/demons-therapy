extends Node

const LEVEL_HOURS: Array[int] =   [0, 1]
const LEVEL_MINUTES: Array[int] = [0, 0]

var level := 1
var hour := 0
var minute := 0

# set outside this script
var ambient_light: DirectionalLight2D
var hud: HUD
var player: Player


@onready var timer := $Timer


func start_level() -> void:
	hour = LEVEL_HOURS[level]
	minute = LEVEL_MINUTES[level]
	timer.start()
	set_ambient_light()
	hud.set_time(hour, minute)


# intermediary function from player to hud
func set_stamina(stamina: int) -> void:
	hud.set_stamina(stamina)


func _on_level_timer_timeout() -> void:
	set_ambient_light()
	
	minute += 1
	if minute >= 60:
		hour += 1
		minute = 0
		if hour == 6:
			print("Time end")
			timer.stop()
	hud.set_time(hour, minute)


func set_ambient_light() -> void:
	if hour < 4:  # from 24:00 to 4:00 
		return
	elif hour < 5:  # from 4:00 to 5:00
		ambient_light.energy = 0.9 - 0.2 * (minute / 60.0)
	else:  # from 5:00 to 6:00
		ambient_light.energy = 0.7 - 0.3 * (minute / 60.0)
