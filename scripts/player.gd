extends CharacterBody2D

@onready var point_light = $light
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D
@onready var lightlimiter = $light/lightlimiter
@onready var progress_bar = $ProgressBar

var hp = 200
const movespeed = 100
const accel = 100
const jumpvelocity = -300
@export var isinair = false
var dis = 20
var ishit = 20

func _process(delta):
	progress_bar.value = hp
	var dir = (get_global_mouse_position() - global_position).normalized()
	point_light.look_at(get_global_mouse_position())
	point_light.global_position = global_position + dir * dis
	lightlimiter.look_at(point_light.global_position)
	
func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("a","d","w","s")

	if direction.x > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk")
	elif direction.x < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk")
	elif not direction.y == 0:
		animated_sprite.play("walk down")
	else:
		animated_sprite.play("idle")
		
	velocity.x = move_toward(velocity.x, movespeed * direction.x, accel)
	velocity.y = move_toward(velocity.y, movespeed * direction.y, accel)
	
	if Input.get_action_strength("space"):
		animation_player.play("jump")  
		animated_sprite.play("jump")
		set_collision_mask_value(14, true)
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
	if not isinair:
		set_collision_mask_value(14, true)
		set_collision_mask_value(2, false)
		set_collision_mask_value(1, true)
		
	move_and_slide()
