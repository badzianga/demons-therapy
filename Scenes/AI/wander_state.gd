class_name WanderState
extends State

@export var actor: Demon
@export var animator: AnimationPlayer
@export var vision: RayCast2D

signal player_seen


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * actor.speed
	print(actor.velocity)


func exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	var collision := actor.move_and_collide(actor.velocity * delta)
	if collision:
		actor.velocity = actor.velocity.bounce(collision.get_normal())
