extends Node2D

@onready var wavenuml = $"../CanvasLayer/wavenum"
@onready var timer = $Timer
var enemy_scene: PackedScene
var spawning = 4
var wavenum = 2

func _ready():
	wavenuml.text = "wave: 1"
	enemy_scene = preload("res://scenes/enemy.tscn")
	spawn_enemies(spawning)

func waves():
	wavenuml.text = "wave: " + str(wavenum)
	wavenum += 1
	spawning = int(spawning * 1.5)

func spawn_enemies(count: int):
	for i in range(count):
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = Vector2(randf() * 800, randf() * 600)
		add_child(enemy_instance)
		enemy_instance.add_to_group("enemies")  # Füge den Feind zur Gruppe hinzu

func _on_timer_timeout():
	waves()
	spawn_enemies(spawning)


func reset_spawner():
	# Stoppe den Timer
	timer.stop()

	wavenum = 2
	spawning = 4
	wavenuml.text = "wave: 1"
	
	# Starte den Timer neu
	timer.start()
