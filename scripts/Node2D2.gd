extends Node2D

# Referenz auf die GradientTexture2D-Ressource
#@export var gradient_texture: GradientTexture2D
@onready var gradient_texture = $"../TextureRect"

# Variable zum Speichern des aktuellen Werts
var grcol := 0

# Bereich, in dem sich grcol bewegen kann (z.B. 1 bis 1000)
var min_value := 1
var max_value := 1000

func _ready():
	update_color()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			

func update_color():
	# Berechnen des Werts im Bereich von 0.0 bis 1.0
	var gradient_position := float(grcol - min_value) / float(max_value - min_value)
	
	# Farbe aus dem GradientTexture abrufen
	var current_color = gradient_texture.get_color(gradient_position)
	
	# Debugging: Farbe ausgeben oder einem Sprite zuweisen
	print("Aktuelle Farbe:", current_color)
	# Beispiel: falls du die Farbe einem Sprite zuweisen möchtest
	# $Sprite.modulate = current_color
