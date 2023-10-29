class_name ChaseState
extends State

@export var actor: Demon
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var vision: RayCast2D
@export var demon_close_sound: AudioStreamPlayer
@export var speed := 200.0

signal player_lost


func enter_state() -> void:
	if not demon_close_sound.playing and randf() < 0.6:
		demon_close_sound.play()
	print("Entered state: ", name)
	set_physics_process(true)
	animator.play("chase")


func exit_state() -> void:
	print("Exited state: ", name)
	set_physics_process(false)
	GameController.player.heartbeat()


func _physics_process(_delta: float) -> void:
	if actor.velocity.x != 0:
		sprite.flip_h = (actor.velocity.x < 0)
	
	var direction := actor.global_position.direction_to(GameController.player.global_position)
	actor.velocity = direction * speed
	actor.move_and_slide()
	
	if vision.is_colliding():
		player_lost.emit()
