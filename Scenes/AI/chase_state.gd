class_name ChaseState
extends State

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var speed := 200.0

signal player_lost


func enter_state() -> void:
	print("Entered state: ", name)
	set_physics_process(true)


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	if actor.velocity.x != 0:
		sprite.flip_h = (actor.velocity.x > 0)
	
	var direction := actor.global_position.direction_to(GameController.player.global_position)
	actor.velocity = direction * speed
	actor.move_and_slide()
	
	if vision.is_colliding():
		player_lost.emit()


func _on_player_detection_area_body_exited(body: Node2D) -> void:
	pass
