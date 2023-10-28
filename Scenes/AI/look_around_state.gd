class_name LookAroundState
extends State

signal player_seen
signal looking_around_finished

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var look_around_timer: Timer


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("look_around")
	look_around_timer.start()


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	if not vision.is_colliding() and actor.player_in_detection_area:
		look_around_timer.stop()
		player_seen.emit()


func _on_look_around_timer_timeout() -> void:
	looking_around_finished.emit()
