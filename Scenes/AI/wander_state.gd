class_name WanderState
extends State

signal player_seen
signal path_finished

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var wander_timer: Timer
@export var speed := 100.0


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("wander")
	reset_path()


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if actor.velocity.x != 0: 
		sprite.flip_h = (actor.velocity.x < 0)
	
	var collision := actor.move_and_collide(actor.velocity * delta)
	if collision:
		actor.velocity = actor.velocity.bounce(collision.get_normal())
	
	if not vision.is_colliding() and actor.player_in_detection_area:
		player_seen.emit()


func reset_path() -> void:
	wander_timer.wait_time = randf_range(2.0, 4.0)
	wander_timer.start()
	#if actor.velocity == Vector2.ZERO:  # TODO: I don't know if this statement necessary, (it is, indeed)
	actor.velocity = Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * speed


func _on_wander_timer_timeout() -> void:
	if randf() < 0.2:
		path_finished.emit()
	else:
		reset_path()
