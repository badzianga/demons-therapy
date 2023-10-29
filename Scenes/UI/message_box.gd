extends TextureRect


func display(type: String) -> void:
	if type == "found":
		$LabelBigger.text = "You found your gold!"
		$LabelSmaller.text = "Now survive until 6 AM..."
	elif type == "start":
		$LabelBigger.text = "Find your gold!"
		$LabelSmaller.text = "Find a shovel and dig up the piles of dirt."
	$AnimationPlayer.play("move")
