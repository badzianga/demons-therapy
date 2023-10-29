extends AudioStreamPlayer


func _ready() -> void:
	random_play()


func random_play() -> void:
	await get_tree().create_timer(10, 30).timeout
	play()


func _on_finished() -> void:
	random_play()
