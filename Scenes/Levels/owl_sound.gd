extends AudioStreamPlayer


func _ready() -> void:
	random_play()


func random_play() -> void:
	await get_tree().create_timer(2, 20).timeout
	play()


func _on_finished() -> void:
	random_play()
