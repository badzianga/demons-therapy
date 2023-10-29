extends ColorRect


func _on_scream_finished() -> void:
	GameController.go_to_therapy("caught")


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("accept"):
		GameController.go_to_therapy("caught")
