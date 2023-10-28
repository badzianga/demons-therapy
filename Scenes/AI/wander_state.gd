class_name WanderState
extends State

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var speed := 125.0

signal player_seen


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * speed


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if actor.velocity.x != 0:
		sprite.flip_h = (actor.velocity.x < 0)
	
	var collision := actor.move_and_collide(actor.velocity * delta)
	if collision:
		actor.velocity = actor.velocity.bounce(collision.get_normal())
	
	if not vision.is_colliding():
		player_seen.emit()


func _on_player_detection_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
