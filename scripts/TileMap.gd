extends TileMap

@onready var player = $"../../player"

func _ready():
	check_player_layers()

func _process(delta):
	check_player_layers()

func check_player_layers():
	# Position des Spielers in globalen Koordinaten
	var player_global_position = player.global_position
	
	# Globale Position in lokale Position der Tilemap umwandeln
	var player_local_position = to_local(player_global_position)
	
	# Lokale Position in Tilemap-Koordinaten umwandeln
	var cell_position = local_to_map(player_local_position)
	
	# Anzahl der Layers
	var layers = get_layers_count()
	
	# Liste für gefundene Layers an dieser Position
	var found_layers = []
	
	# Überprüfen, auf welchen Layers sich der Spieler befindet
	for layer in range(layers):
		if get_cell_source_id(layer, cell_position) != -1:
			found_layers.append(layer)
	
	if found_layers.size() > 0:
		print("Spieler befindet sich auf folgenden Layers: ", found_layers)
	else:
		print("Spieler befindet sich auf keinem Layer.")
