class_name Pile
extends Area2D

const DugPileSprite := preload("res://Assets/Environment/pile_2.png")

@onready var e_key := $EKey
@onready var sprite := $Sprite


func dig() -> void:
	$SmokeParticles.emitting = true
	sprite.texture = DugPileSprite
	$CollisionShape.set_deferred("disabled", true)


func _on_area_entered(_area: Area2D) -> void:
	e_key.visible = true
	sprite.material.set_shader_parameter("width", 2.0)


func _on_area_exited(_area: Area2D) -> void:
	e_key.visible = false
	sprite.material.set_shader_parameter("width", 0.0)
