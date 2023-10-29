class_name SkillCheck
extends Sprite2D

signal skill_checked
signal skill_failed

var multiplier := 240.0
var min_angle: int
var max_angle: int

@onready var center := $Center


func _ready() -> void:
	visible = false
	set_physics_process(false)

func start() -> void:
	visible = true
	set_physics_process(true)
	if randf() < 0.5:
		multiplier *= -1.0
	# precious hack, eliminate edge case when 0 < rotation < 30 or 330 < rotation < 360 
	rotation_degrees = 4 * randi_range(8, 82)
	
	min_angle = int(rotation_degrees) - 30
	max_angle = int(rotation_degrees) + 30
	center.rotation_degrees = 4 * randi_range(0, 89)



func _physics_process(delta: float) -> void:
	center.rotation_degrees = int(center.rotation_degrees + multiplier * delta) % 360


func check_skill(pile: Pile) -> void:
	var pointer := int(center.rotation_degrees + rotation_degrees) % 360
	if pointer < max_angle and pointer > min_angle:
		pile.dig()
		start()
		if pile.digs_left <= 0:
			set_physics_process(false)
			visible = false
			skill_checked.emit()
		print("skill checked!")
	else:
		set_physics_process(false)
		visible = false
		skill_failed.emit()
		print("failed you imbecile!")
	
	print(min_angle, "<", pointer, "<", max_angle)
	
