extends AnimatedSprite2D

var point_light
var raycast
var raycast1
var raycast2

var kills = 0
var canhit = false
var speed 
var accel = 7
var player
var velocity = Vector2()
@onready var nav = $"../NavigationAgent2D"
@onready var color_rect = $"../ColorRect"
@onready var enemy = $".."

var transition_duration = 0.4  # Dauer des Farbübergangs in Sekunden
var transition_time = 0.0  # Zeit seit Beginn des Farbübergangs
var original_color = Color(0, 0, 0, 1)  # Ursprüngliche Farbe des Feindes
var target_color = Color(0, 0, 0, 1)  # Ziel-Farbe des Feindes
var current_color = Color(0, 0, 0, 1)  # Aktuelle Farbe des Feindes
var colors = [Color(1, 0, 0, 1), Color(0, 1, 0, 1), Color(0, 0, 1, 1)]  # Vorab definierte Farben
var is_transitioning = false  # Flag, um zu überprüfen, ob ein Übergang stattfindet

func _ready():
	speed = randf_range(60,80)
	player = get_node("/root/Gamemanager/player")
	
	# Setzt die Initialfarbe des Sprites auf eine zufällige Farbe aus der Liste
	original_color = colors[randi() % colors.size()]
	self.modulate = original_color
	current_color = original_color

	point_light = get_node("/root/Gamemanager/player/light")
	raycast = get_node("/root/Gamemanager/player/light/RayCast2D")
	raycast1 = get_node("/root/Gamemanager/player/light/RayCast2D3")
	raycast2 = get_node("/root/Gamemanager/player/light/RayCast2D2")

func _physics_process(delta):
	if canhit and closeenaugh():
		canhit = false
		hit_player()  # Spieler treffen und Lebenspunkte verringern
	
	if rccol():
		if point_light and point_light.has_method("get_color"):
			# Bestimme die Ziel-Farbe für den Feind basierend auf der neuen Lichtfarbe und mache sie heller
			var light_color = point_light.get_color()
			target_color = light_color + Color(0.2, 0.2, 0.2, 0)  # Heller machen durch Hinzufügen von Weiß

			# Wenn sich die Lichtfarbe ändert, beginne den Farbübergang
			if not is_transitioning:
				is_transitioning = true
				transition_time = 0.0
				# Setze die aktuelle Farbe als Basisfarbe für den Übergang
				current_color = self.modulate
	# Stoppe den Übergang, wenn der Raycast nicht mehr den Feind trifft, aber behalte die aktuelle Farbe
	else:
		if is_transitioning:
			is_transitioning = false
			current_color = self.modulate  # Behalte die aktuelle Farbe als Basisfarbe

	# Fortsetzen des Farbübergangs, falls notwendig
	if is_transitioning:
		transition_time += delta
		var progress = clamp(transition_time / transition_duration, 0.0, 1.0)
		
		# Interpolieren nur der RGB-Werte
		var interpolated_r = lerp(current_color.r, target_color.r, progress)
		var interpolated_g = lerp(current_color.g, target_color.g, progress)
		var interpolated_b = lerp(current_color.b, target_color.b, progress)
		var interpolated_a = current_color.a  # Behalte den Alpha-Wert der Ausgangsfarbe bei
		
		self.modulate = Color(interpolated_r, interpolated_g, interpolated_b, interpolated_a)
		
		if progress >= 1.0:
			is_transitioning = false  # Übergang abgeschlossen
			current_color = self.modulate  # Setze die finale Farbe als neue Basisfarbe
	
	if are_colors_similar(color_rect.color, current_color, 0.5):
		deleteinstance()
		kills += 1

func _process(delta):
	var direction = Vector2()
	
	nav.target_position = player.position
	if enemy.position.distance_to(player.position) > 4:
		direction = nav.get_next_path_position() - enemy.global_position
		direction = direction.normalized()
	
		velocity = velocity.lerp(direction * speed, accel * delta)
	
		enemy.velocity = velocity
		enemy.move_and_slide()

func rccol() -> bool:
	return raycast.get_collider() == get_parent()
	return raycast1.get_collider() == get_parent()
	return raycast2.get_collideer() == get_parent()

func are_colors_similar(c1: Color, c2: Color, threshold: float) -> bool:
	var r_diff = c1.r - c2.r
	var g_diff = c1.g - c2.g
	var b_diff = c1.b - c2.b
	var distance = sqrt(r_diff * r_diff + g_diff * g_diff + b_diff * b_diff)
	return distance < threshold

func deleteinstance():
	queue_free()
	enemy.queue_free()

func _on_timer_timeout():
	canhit = true

func closeenaugh():
	if self.global_position.distance_to(player.global_position) < 5.0:
		return true
	else:
		return false

func hit_player():
	if player:
		player.hp -= 10  # Verringere die Lebenspunkte des Spielers um 10
		if player.hp <= 0:
			player.hp = 200
			var game_manager = get_node("/root/Gamemanager")
			game_manager.reset_game()  # Setze das Spiel zurück
			get_tree().paused = true
