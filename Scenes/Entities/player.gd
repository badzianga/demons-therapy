extends CharacterBody2D


@export var speed = 300.0

var direction := Vector2.ZERO

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animations()


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	if direction:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func handle_animations() -> void:
	if direction.x == 0:
		return
	sprite.flip_h = (direction.x < 0)
