class_name Demon
extends CharacterBody2D

@export var speed := 300.0

@onready var vision := $Vision


func _physics_process(_delta: float) -> void:
	vision.target_position =  GameController.player.global_position - global_position


func _on_player_detection_area_body_entered(_body: Player) -> void:
	$HelloThereSound.play()
