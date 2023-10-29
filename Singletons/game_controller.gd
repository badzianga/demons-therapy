extends Node

const LEVEL_HOURS: Array[int] =   [0, 4, 3, 1]
const LEVEL_MINUTES: Array[int] = [0, 30, 0, 0]
const MUSIC: Dictionary = {
	"menu": preload("res://Assets/Music/menu_background.mp3"),
	"therapy": preload("res://Assets/Music/elevator.mp3"),
	"level": preload("res://Assets/Music/background_ambient.mp3"),
}

var level := 0
var hour := 0
var minute := 0
var level_completion_state := "complete"

# set outside this script
var ambient_light: DirectionalLight2D
var hud: HUD
var player: Player

@onready var timer := $Timer
@onready var music_player := $MusicPlayer


func _ready() -> void:
	randomize()


func reset_game() -> void:
	level = 0
	hour = 0
	minute = 0
	timer.stop()


func play_music(type: String) -> void:
	music_player.stream = MUSIC[type]
	music_player.play()


func start_game() -> void:
	print("I GO TO THERAPYYYYY")
	go_to_therapy("complete")


func go_to_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
	reset_game()


func go_to_caught() -> void:
	timer.stop()
	music_player.stop()
	get_tree().change_scene_to_file("res://Scenes/Levels/black_screen.tscn")


func go_to_world() -> void:
	if level < 4:
		get_tree().change_scene_to_file("res://Scenes/Levels/world.tscn")
	else:
		go_to_menu()


func go_to_therapy(state_name: String) -> void:
	timer.stop()
	level_completion_state = state_name
	if state_name == "complete":
		level += 1
	get_tree().change_scene_to_file("res://Scenes/UI/therapy.tscn")


func start_level() -> void:
	hour = LEVEL_HOURS[level]
	minute = LEVEL_MINUTES[level]
	timer.start()
	set_ambient_light()
	print("world should be ready here")
	hud.set_time(hour, minute)


# intermediary function from player to hud
func set_stamina(stamina: int) -> void:
	hud.set_stamina(stamina)


func _on_level_timer_timeout() -> void:
	set_ambient_light()
	
	minute += 1
	if minute >= 60:
		hour += 1
		minute = 0
		if hour == 6:
			print("Time end")
			timer.stop()
			if player.has_treasure:
				go_to_therapy("complete")
			else:
				go_to_therapy("timeout")
	hud.set_time(hour, minute)


func set_ambient_light() -> void:
	if hour < 4:  # from 24:00 to 4:00 
		return
	elif hour < 5:  # from 4:00 to 5:00
		ambient_light.energy = 0.99 - 0.1 * (minute / 60.0)
	else:  # from 5:00 to 6:00
		ambient_light.energy = 0.89 - 0.2 * (minute / 60.0)
