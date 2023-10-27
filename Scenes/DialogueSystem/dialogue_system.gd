extends TextureRect


signal name_changed(actor_name: String)
 
@export_file("*.json") var dialog_path: String 
@export var _text_speed := 0.025

var _dialog: Array
var _phrase_number := 0
var _finished := false

@onready var _name_label := $NameLabel
@onready var _text_label := $TextLabel
@onready var _indicator := $Indicator
@onready var _timer := $Timer


func _ready() -> void:
	$Timer.wait_time = _text_speed
	_dialog = _get_dialog()
	_next_phrase()


func _process(_delta: float) -> void:
	_indicator.visible = _finished
	if Input.is_action_just_pressed("accept"):
		if _finished:
			_next_phrase()
		else:
			_text_label.visible_characters = len(_text_label.text)


func _get_dialog() -> Array:
	var file := FileAccess.open(dialog_path, FileAccess.READ)
	var content := file.get_as_text()

	var json: Array = JSON.parse_string(content)

	if typeof(json) == TYPE_ARRAY:
		return json
	else:
		return []


func _next_phrase() -> void:
	if _phrase_number >= len(_dialog):
		queue_free()
		return

	_finished = false
	_name_label.bbcode_text = _dialog[_phrase_number]["Name"]
	_text_label.bbcode_text = _dialog[_phrase_number]["Text"]
	name_changed.emit(_dialog[_phrase_number]["Name"])

	_text_label.visible_characters = 0
	while _text_label.visible_characters < len(_text_label.text):
		_text_label.visible_characters += 1

		_timer.start()
		await _timer.timeout

	_finished = true
	_phrase_number += 1
