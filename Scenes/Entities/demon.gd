class_name Demon
extends CharacterBody2D

const SOUNDS := {
	0: preload("res://Assets/Sounds/Demon/demon_scream.mp3"),
	1: preload("res://Assets/Sounds/Demon/screach_inhale.mp3"),
	2: preload("res://Assets/Sounds/Demon/screach_inhale_2.mp3"),
	3: preload("res://Assets/Sounds/Demon/hello_there.mp3"),
}

var player_in_detection_area := false

@onready var vision := $Vision
@onready var fsm := $FiniteStateMachine as FiniteStateMachine
@onready var wander_state := $FiniteStateMachine/WanderState as WanderState
@onready var chase_state := $FiniteStateMachine/ChaseState as ChaseState
@onready var look_around_state := $FiniteStateMachine/LookAroundState as LookAroundState
@onready var scary_sound := $ScarySound


func _ready() -> void:
	wander_state.player_seen.connect(fsm.change_state.bind(chase_state))
	wander_state.path_finished.connect(fsm.change_state.bind(look_around_state))
	
	look_around_state.player_seen.connect(fsm.change_state.bind(chase_state))
	look_around_state.looking_around_finished.connect(fsm.change_state.bind(wander_state))
	
	chase_state.player_lost.connect(fsm.change_state.bind(look_around_state))


func _physics_process(_delta: float) -> void:
	vision.target_position =  GameController.player.global_position - global_position
	
	if not scary_sound.playing and randf() < 0.02:
		if randf() > 0.01:
			scary_sound.stream = SOUNDS[randi_range(0, 2)]
			scary_sound.volume_db = 0.0
		else:
			scary_sound.stream = SOUNDS[3]
			scary_sound.volume_db = 20.0
		scary_sound.play()


func _on_player_detection_area_body_entered(_body: Player) -> void:
	player_in_detection_area = true


func _on_player_detection_area_body_exited(_body: Player) -> void:
	player_in_detection_area = false


func _on_catch_area_area_entered(_area: Area2D) -> void:
	GameController.go_to_caught()
