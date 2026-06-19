extends Panel

var color_variable : Color = Color(1,0,0,1)
var gradient_position : float = 0.0 # Position im Gradient
@onready var label = $Label

func _ready():
	# Setze Standardfarbe oder Initialisierung falls notwendig
	color_variable = _get_color_from_gradient(gradient_position)
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			label.text("ji")
	#	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed():
	#		print("h")
	#		_change_gradient_position(0.01)

func _change_gradient_position(delta):
	gradient_position = clamp(gradient_position + delta, 0.0, 1.0)
	color_variable = _get_color_from_gradient(gradient_position)

func _get_color_from_gradient(position: float) -> Color:
	# Hier definierst du, wie die Farbe basierend auf der Position bestimmt wird
	return Color(1.0 - position, 0.0, position)  # Beispiel: Übergang von Rot zu Blau

func _draw():
	# Optional: Zeichne den aktuellen Farbverlauf auf das Panel
	draw_rect(Rect2(Vector2(), size), _get_color_from_gradient(gradient_position))
