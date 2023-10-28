extends Control

@onready var dialogue_system := $DialogueSystem as DialogueSystem
@onready var bieda_image := $BiedaImage


func _ready() -> void:
	dialogue_system.image_changed.connect(_on_image_changed)
	dialogue_system.dialog_finished.connect(_on_dialog_finished)
	dialogue_system.dialog_path = "res://Assets/Dialogs/dialog_" + str(GameController.level) + ".json"
	dialogue_system._next_phrase()


func _on_image_changed(image_name: String) -> void:
	bieda_image.texture = load("res://Assets/UI/" + image_name)


func _on_skip_button_pressed() -> void:
	GameController.go_to_world()


func _on_dialog_finished() -> void:
	GameController.go_to_world()
