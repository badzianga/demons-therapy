class_name LookAroundState
extends State

signal player_seen
signal looking_around_finished

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var look_around_timer: Timer
@export var player_detection_area: Area2D


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("look_around")
	look_around_timer.start()
	player_detection_area.scale = Vector2(2.0, 2.0)


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)
	player_detection_area.scale = Vector2(1.0, 1.0)


func _physics_process(_delta: float) -> void:
	if not vision.is_colliding() and actor.player_in_detection_area:
		look_around_timer.stop()
		player_seen.emit()
	print("Global position: ", actor.global_position)


func _on_look_around_timer_timeout() -> void:
	looking_around_finished.emit()
