class_name CheckState
extends State

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var speed := 150.0
@export var collision_shape: CollisionShape2D
@export var vision: RayCast2D

signal player_lost
signal player_found

var target: Vector2
var direction: Vector2

func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("wander")
	target = GameController.player.global_position
	collision_shape.set_deferred("disabled", true)
	actor.modulate = Color(1.0, 1.0, 1.0, 0.5)
	direction = actor.global_position.direction_to(GameController.player.global_position)


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)
	actor.modulate = Color(1.0, 1.0, 1.0, 1.0)
	collision_shape.set_deferred("disabled", false)


func _physics_process(delta: float) -> void:
	if direction.x != 0.0:
		sprite.flip_h = (direction.x < 0.0)

	actor.global_position = actor.global_position.move_toward(target, speed * delta)

	if actor.global_position == target:
		if not vision.is_colliding():
			player_found.emit()
		else:
			player_lost.emit()
