extends StaticBody2D

@onready var sprite := $Sprite


func _on_detection_area_area_entered(_area: Area2D) -> void:
	if not GameController.player.has_treasure:
		sprite.material.set_shader_parameter("width", 2.0)


func _on_detection_area_area_exited(_area: Area2D) -> void:
	sprite.material.set_shader_parameter("width", 0.0)
