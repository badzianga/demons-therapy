extends Node2D

const PileScene := preload("res://Scenes/Environment/pile.tscn")

const PILE_AMOUNTS: Array[int] = [0, 3, 7, 12]
var spawned_treasure := false

@onready var pile_locations: Node2D = $PileLocations


func _ready() -> void:
	var pile_amount := PILE_AMOUNTS[GameController.level]
	var piles := pile_locations.get_children()
	while (pile_amount > 0):
		pile_amount -= 1
		var random_pile_location: Marker2D = piles.pick_random()
		piles.erase(random_pile_location)
		var pile := PileScene.instantiate()
		pile.global_position = random_pile_location.global_position
		if not spawned_treasure:
			spawned_treasure = true
			pile.has_treasure = true
		add_child(pile)
