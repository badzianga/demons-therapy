extends Node2D


func _ready() -> void:
	var LevelScene := load("res://Scenes/Levels/level_" + str(GameController.level) + ".tscn")
	GameController.ambient_light = $AmbientLight
	GameController.hud = $HUD
	GameController.start_level()
	GameController.play_music("level")
