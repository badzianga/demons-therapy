extends Node2D


func _ready() -> void:
	var LevelScene := load("res://Scenes/Levels/level_" + str(GameController.level) + ".tscn")
	var level: Node2D = LevelScene.instantiate()
	add_child(level)
	GameController.ambient_light = $AmbientLight
	GameController.hud = $HUD
	GameController.start_level()
	GameController.play_music("level")
	GameController.hud.message_box.display("start")
