extends Camera2D


func _ready() -> void:
	var top_left := $Positions/TopLeft
	limit_top = top_left.position.y
	limit_left = top_left.position.x
	
	var bottom_right := $Positions/BottomRight
	limit_bottom = bottom_right.position.y
	limit_right = bottom_right.position.x
