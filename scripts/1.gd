extends TileMap

@onready var player = $"../../player"
@onready var no_oc = $"../no oc"
@onready var some_oc = $"../some oc"

func _ready():
	self.global_position = Vector2(0,0)
	check_player_layers()

func _process(delta):
	check_player_layers()

func check_player_layers():
	var player_global_position = player.global_position
	var player_local_position = to_local(player_global_position)
	var cell_position = local_to_map(player_local_position)
	var layers = get_layers_count()
	var found_layers = []
	
	for layer in range(layers):
		if get_cell_source_id(layer, cell_position) != -1:
			found_layers.append(layer)
	
	if found_layers.max() == 0:
		self.global_position = Vector2(0,0)
	else:
		no_oc.global_position = Vector2(0,0)
		some_oc.global_position = Vector2(0,0)
		self.global_position = Vector2(1000,1000)
		print("all: " + str(self.global_position))
