class_name Demon
extends CharacterBody2D

@onready var vision := $Vision
@onready var fsm := $FiniteStateMachine as FiniteStateMachine
@onready var wander_state := $FiniteStateMachine/WanderState as WanderState
@onready var chase_state := $FiniteStateMachine/ChaseState as ChaseState


func _ready() -> void:
	wander_state.player_seen.connect(fsm.change_state.bind(chase_state))
	chase_state.player_lost.connect(fsm.change_state.bind(wander_state))


func _physics_process(_delta: float) -> void:
	vision.target_position =  GameController.player.global_position - global_position


func _on_player_detection_area_body_entered(_body: Player) -> void:
	$HelloThereSound.play()
