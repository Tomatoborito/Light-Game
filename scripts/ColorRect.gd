extends ColorRect

@onready var animated_sprite_2d = $"../AnimatedSprite2D"

# Definiere die Liste der Farben
var color_list = [
	Color(1.0, 0.0, 0.0),   # Rot
	Color(1.0, 0.5, 0.0),   # Orange
	Color(1.0, 1.0, 0.0),   # Gelb
	Color(0.0, 1.0, 0.0),   # Grün
	Color(0.0, 1.0, 1.0),   # Cyan
	Color(0.0, 0.0, 1.0),   # Blau
	Color(0.5, 0.0, 0.5),   # Lila
	Color(1.0, 0.0, 1.0)    # Pink
]

func _process(delta):
	pass

# Erstelle eine Funktion, die eine zufällige Farbe aus der Liste zurückgibt, aber nicht die des Sprites
func get_random_color_excluding(excluded_color: Color) -> Color:
	var possible_colors = []
	for color in color_list:
		if color != excluded_color:
			possible_colors.append(color)
			
	var index = randi() % possible_colors.size()
	return possible_colors[index]

func _ready():
	var sprite_color = animated_sprite_2d.modulate
	var random_color = get_random_color_excluding(sprite_color)
	self.color = random_color
