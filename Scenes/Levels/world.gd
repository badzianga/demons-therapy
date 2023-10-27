extends Node2D


func _ready() -> void:
	GameController.ambient_light = $AmbientLight
	GameController.hud = $HUD
	GameController.start_level()
