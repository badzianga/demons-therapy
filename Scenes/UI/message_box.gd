extends TextureRect


func display(type: String) -> void:
	if type == "found":
		$AnimationPlayer.speed_scale = 1.0
		$LabelBigger.text = "You found your gold!"
		$LabelSmaller.text = "Now survive 30 minutes or until 6 AM..."
	elif type == "start":
		$AnimationPlayer.speed_scale = 0.75
		$LabelBigger.text = "Find your gold before 6 AM!"
		$LabelSmaller.text = "Find a shovel and dig up the piles of dirt."
	$AnimationPlayer.play("move")
