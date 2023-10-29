class_name Player
extends CharacterBody2D

const SkillCheckScene := preload("res://Scenes/UI/skill_check.tscn")

@export var speed := 175.0
@export var sprint_factor := 1.75

var direction := Vector2.ZERO
var stamina := 100
var stamina_depleted := false
var sprinting := false
var skill_checking := false
var has_shovel := false
var collides_with_box := false
var has_treasure := false
var theoretically_has_treasure := false

var pile: Pile = null

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var walk_sound := $WalkSound
@onready var skill_check := $TopHead/SkillCheck as SkillCheck
@onready var e_key := $TopHead/EKey
@onready var pick_sound := $PickSound
@onready var camera := $PlayerCamera


func _ready() -> void:
	GameController.player = self
	skill_check.skill_checked.connect(_on_skill_checked)
	skill_check.skill_failed.connect(_on_skill_failed)
	e_key.visible = false


func _physics_process(delta: float) -> void:
	check_digging()
	if not skill_checking:
		handle_movement()
	handle_animations()
	GameController.set_stamina(stamina)
	handle_camera(delta)


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	if direction:
		if Input.is_action_pressed("sprint") and not stamina_depleted:
			sprinting = true
			velocity = direction.normalized() * speed * sprint_factor
			stamina -= 2
			if stamina < 0:
				stamina_depleted = true
		else:
			sprinting = false
			velocity = direction.normalized() * speed
		
		if not walk_sound.playing:
			if sprinting:
				walk_sound.pitch_scale = randf_range(1.15, 1.45)
			else:
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
		if sprinting:
			animation_player.play("run")
		else:
			animation_player.play("walk")
	else:
		animation_player.play("idle")
	if direction.x == 0:
		return
	sprite.flip_h = (direction.x < 0)


func handle_camera(delta: float) -> void:
	if sprinting:
		camera.zoom = camera.zoom.move_toward(Vector2(1.1, 1.1), 0.45 * delta)
	else:
		camera.zoom = camera.zoom.move_toward(Vector2(1.3, 1.3), 0.45 * delta)


func check_digging() -> void:
	if Input.is_action_just_pressed("dig") and collides_with_box:
		has_shovel = true
		GameController.hud.set_icon("shovel")
	if Input.is_action_just_pressed("dig") and pile != null and has_shovel:
		direction = Vector2.ZERO
		if not skill_checking:
			skill_check.start()
			skill_checking = true
		else:
			if skill_check.visible:
				skill_check.check_skill(pile)


func _on_dig_area_area_entered(area: Area2D) -> void:
	if has_treasure:
		return
	if area.name == "ShovelBoxArea":
		collides_with_box = true
		if not has_shovel and not has_treasure:
			e_key.visible = true
		return
	pile = area
	if has_shovel:
		e_key.visible = true


func _on_dig_area_area_exited(area: Area2D) -> void:
	if area.name == "ShovelBoxArea":
		collides_with_box = false
		e_key.visible = false
		return
	if pile:
		theoretically_has_treasure = pile.has_treasure
	pile = null
	e_key.visible = false


func _on_skill_checked() -> void:
	has_treasure = theoretically_has_treasure
	if has_treasure:
		GameController.hud.set_icon("treasure")
		has_shovel = false
		pick_sound.play()
	skill_checking = false
	e_key.visible = false


func _on_skill_failed() -> void:
	has_shovel = false
	GameController.hud.set_icon("broken")
	skill_checking = false
	e_key.visible = false
