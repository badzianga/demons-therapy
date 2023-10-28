class_name Player
extends CharacterBody2D


@export var speed := 175.0
@export var sprint_factor := 1.75

var direction := Vector2.ZERO
var stamina := 100
var stamina_depleted := false

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var walk_sound := $WalkSound


func _ready() -> void:
	GameController.player = self


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animations()
	GameController.set_stamina(stamina)


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	if direction:
		if Input.is_action_pressed("sprint") and not stamina_depleted:
			velocity = direction.normalized() * speed * sprint_factor
			stamina -= 2
			if stamina < 0:
				stamina_depleted = true
		else:
			velocity = direction.normalized() * speed
		
		if not walk_sound.playing:
			walk_sound.pitch_scale = randf_range(0.85, 1.15)
			walk_sound.play()
	else:
		velocity = Vector2.ZERO
	
	stamina = min(stamina + 1, 100)
	if stamina_depleted and stamina == 100:
		stamina_depleted = false

	move_and_slide()


func handle_animations() -> void:
	if direction != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	if direction.x == 0:
		return
	sprite.flip_h = (direction.x < 0)
