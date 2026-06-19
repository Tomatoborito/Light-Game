extends Control

@onready var options = $"../options"
@export var game_manager : Gamemanager
@export var pauseable = true
# Called when the node enters the scene tree for the first time.
func _ready():
	options.hide()
	hide()
	game_manager.connect("toggle_paused", _on_gamemng_paused)
	
func _on_gamemng_paused(is_paused : bool):
	if is_paused and pauseable:
		show()
	else:
		hide()
		options.hide()
		pauseable = true


func _on_resume_pressed():
	game_manager.game_paused = false


func _on_exit_pressed():
	get_tree().quit()

func _on_options_pressed():
	pauseable = false
	hide()
	options.show()
	
