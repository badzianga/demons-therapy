extends Control


func _ready() -> void:
	print("Menu started")
	GameController.play_music("menu")


func _on_start_button_pressed() -> void:
	print("Start pressed")
	GameController.start_game()


func _on_quit_button_button_down() -> void:
	print("Quiting...")
	get_tree().quit()
