class_name Pile
extends Area2D

const DugPileSprite := preload("res://Assets/Environment/pile_2.png")
const SmokeParticlesScene := preload("res://Scenes/Entities/smoke_particles.tscn")

var digs_left: int
var has_treasure := false

@onready var sprite := $Sprite
@onready var dig_sound := $DigSound



func _ready() -> void:
	digs_left = randi_range(3, 5)


func dig() -> void:
	digs_left -= 1
	dig_sound.pitch_scale = randf_range(0.8, 1.2)
	dig_sound.play()
	var smoke_scene := SmokeParticlesScene.instantiate()
	add_child(smoke_scene)
	$SmokeParticles.emitting = true
	if digs_left <= 0:
		sprite.texture = DugPileSprite
		$CollisionShape.set_deferred("disabled", true)


func _on_area_entered(_area: Area2D) -> void:
	sprite.material.set_shader_parameter("width", 2.0)


func _on_area_exited(_area: Area2D) -> void:
	sprite.material.set_shader_parameter("width", 0.0)
