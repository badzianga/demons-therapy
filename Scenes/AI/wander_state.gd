class_name WanderState
extends State

signal player_seen
signal path_finished

const WANDER_VISION_RADIUS = 192

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var player_detection_area: Area2D
@export var vision: RayCast2D
@export var speed := 125.0

var player_in_detection_area := false


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("wander")
	if actor.velocity == Vector2.ZERO:  # TODO: I don't know if this statement necessary
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * speed


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if actor.velocity.x != 0:  # TODO: Also don't know if this statement is necessary 
		sprite.flip_h = (actor.velocity.x < 0)
	
#	var collision := actor.move_and_collide(actor.velocity * delta)
#	if collision:
#		actor.velocity = actor.velocity.bounce(collision.get_normal())
	
	if not vision.is_colliding() and player_in_detection_area:
		player_seen.emit()
	# here goes look around state check


func _on_player_detection_area_body_entered(_body: Player) -> void:
	player_in_detection_area = true


func _on_player_detection_area_body_exited(_body: Player) -> void:
	player_in_detection_area = false
