class_name HUD
extends CanvasLayer

@onready var time_label := $TimeLabel
@onready var stamina_bar := $StaminaBar


# called in game controller
func set_time(hour: int, minute: int) -> void:
	var minute_string: String
	if minute < 10:
		minute_string = "0" + str(minute) 
	else:
		minute_string = str(minute)
	time_label.text = str(hour) + " AM" + "\n(" + str(hour) + ":" + minute_string + ")"


# called in game controller by player
func set_stamina(stamina: int) -> void:
	stamina_bar.value = stamina
