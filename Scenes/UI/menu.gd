extends Control


func _ready() -> void:
	GameController.play_music("menu")


func _on_start_button_pressed() -> void:
	GameController.start_game()


func _on_quit_button_button_down() -> void:
	get_tree().quit()
