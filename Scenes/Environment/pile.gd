class_name Pile
extends Area2D

const DugPileSprite := preload("res://Assets/Environment/pile_2.png")

@onready var e_key := $EKey


func dig() -> void:
	$SmokeParticles.emitting = true
	$Sprite.texture = DugPileSprite
	$CollisionShape.set_deferred("disabled", true)


func _on_area_entered(_area: Area2D) -> void:
	e_key.visible = true


func _on_area_exited(_area: Area2D) -> void:
	e_key.visible = false
