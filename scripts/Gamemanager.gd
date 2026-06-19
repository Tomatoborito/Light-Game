extends Node2D

class_name Gamemanager

signal toggle_paused(is_paused: bool)
@onready var survived_time = $"CanvasLayer/Control/Panel/survived time"
@onready var player = $player

var survtime = 0
var grcol = 0
@onready var control = $CanvasLayer/Control

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_paused", game_paused)

func _ready():
	control.hide()
	survtime = 0
	
func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		game_paused = !game_paused

func reset_game():
	# Setze den Spawner zurück
	var spawner = get_node("/root/Gamemanager/spawner")
	if spawner:
		spawner.reset_spawner()
		survived_time.text = "Survived time: " + str(survtime) + " Seconds"
		survtime = 0
		control.show()
		


func _on_play_pressed():
	player.global_position = Vector2(40,40)
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()
	get_tree().paused = false
	control.hide()


func _on_timer_timeout():
	survtime += 1


func _on_exit_pressed():
	get_tree().quit()
