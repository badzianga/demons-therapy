extends Sprite2D

@onready var light := $Light
var time: float
var speed: float
var pos: Vector2
var counter_clockwise: bool


func _ready() -> void:
	time = randf_range(-3.0, 3.0)
	speed = randfn(7.0, 13.0)
	pos = global_position
	counter_clockwise = (randf() < 0.5)


func _physics_process(delta: float) -> void:
	time += delta
	pulse()
	move()


func pulse() -> void:
	var l_scale = 1 + 0.25 * sin(time)
	light.scale = Vector2(l_scale, l_scale)


func move() -> void:
	if counter_clockwise:
		global_position = Vector2(pos.x + speed * sin(time), pos.y + speed * cos(time))
	else:
		global_position = Vector2(pos.x + speed * cos(time), pos.y + speed * sin(time))
