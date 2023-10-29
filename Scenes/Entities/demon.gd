class_name Demon
extends CharacterBody2D

var player_in_detection_area := false

@onready var vision := $Vision
@onready var fsm := $FiniteStateMachine as FiniteStateMachine
@onready var wander_state := $FiniteStateMachine/WanderState as WanderState
@onready var chase_state := $FiniteStateMachine/ChaseState as ChaseState
@onready var look_around_state := $FiniteStateMachine/LookAroundState as LookAroundState


func _ready() -> void:
	wander_state.player_seen.connect(fsm.change_state.bind(chase_state))
	wander_state.path_finished.connect(fsm.change_state.bind(look_around_state))
	
	look_around_state.player_seen.connect(fsm.change_state.bind(chase_state))
	look_around_state.looking_around_finished.connect(fsm.change_state.bind(wander_state))
	
	chase_state.player_lost.connect(fsm.change_state.bind(look_around_state))


func _physics_process(_delta: float) -> void:
	vision.target_position =  GameController.player.global_position - global_position


func _on_player_detection_area_body_entered(_body: Player) -> void:
	player_in_detection_area = true


func _on_player_detection_area_body_exited(_body: Player) -> void:
	player_in_detection_area = false


func _on_catch_area_area_entered(_area: Area2D) -> void:
	GameController.go_to_caught()
