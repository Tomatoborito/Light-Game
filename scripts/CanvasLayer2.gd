extends CanvasLayer

var point_light
var gradient_colors = [
	Color(1.0, 0.0, 0.0),   # Rot
	Color(1.0, 0.5, 0.0),   # Orange
	Color(1.0, 1.0, 0.0),   # Gelb
	Color(0.0, 1.0, 0.0),   # Grün
	Color(0.0, 1.0, 1.0),   # Cyan
	Color(0.0, 0.0, 1.0),   # Blau
	Color(0.5, 0.0, 0.5),   # Lila
	Color(1.0, 0.0, 1.0)    # Pink
]
var value = 400 

@onready var marker = $Panel/Sprite2D
@onready var gradient = $Panel/Sprite2D2
@onready var color_rect = $Panel/ColorRect
@onready var light = $"../light"


func _ready():
	pass
	
func _process(delta):
	var colorf = get_color_from_value(value)
	color_rect.color = colorf
	if value >= 60:
		marker.position.y = value
	light.color = colorf

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			if value < 700:
				value += 20
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			if value > 0:
				value -= 20

func get_color_from_value(value) -> Color:
	var num_colors = gradient_colors.size()
	
	if num_colors == 1:
		return gradient_colors[0]
	
	var segment_length = 720.0 / float(num_colors - 1)
	
	# Berechne den Index des aktuellen Segments
	var index = int(value / segment_length)
	
	# Verhindere Indexüberlauf
	index = clamp(index, 0, num_colors - 2)
	
	# Berechne den Interpolationswert innerhalb des aktuellen Segments
	var t = (value - index * segment_length) / segment_length
	
	# Hole die benachbarten Farben
	var color1 = gradient_colors[index]
	var color2 = gradient_colors[index + 1]
	
	# Interpoliere zwischen den benachbarten Farben
	return color1.lerp(color2, t)
