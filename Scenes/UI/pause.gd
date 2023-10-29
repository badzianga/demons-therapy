extends CanvasLayer


func _ready() -> void:
	visible = false
	$Background/PauseContainer/AudioSettings/HBoxContainer/MusicSlider.value = AudioServer.get_bus_volume_db(1)
	$Background/PauseContainer/AudioSettings/HBoxContainer2/SoundsSlider.value = AudioServer.get_bus_volume_db(2)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true


func set_bus_volume(bus_index: int, value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	GameController.go_to_menu()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_music_slider_value_changed(value: float) -> void:
	if value > -40.0:
		set_bus_volume(1, value)
	else:
		set_bus_volume(1, -100.0)


func _on_sounds_slider_value_changed(value: float) -> void:
	if value > -40.0:
		set_bus_volume(2, value)
	else:
		set_bus_volume(2, -100.0)
