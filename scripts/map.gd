extends Node2D

@onready var player = $"../player"


func _ready():
	check_player_tilemaps()

func _process(delta):
	check_player_tilemaps()

func check_player_tilemaps():
	#Position des Spielers in globalen Koordinaten
	var player_global_position = player.global_position
	
#	Liste für gefundene TileMaps
	var found_tilemaps = []
	
#	Überprüfen, auf welchen TileMaps sich der Spieler befindet
	for tilemap in get_children():
		if tilemap is TileMap:
		# Globale Position in lokale Position der Tilemap umwandeln
			var player_local_position = tilemap.to_local(player_global_position)
	
			# Lokale Position in Tilemap-Koordinaten umwandeln
			var cell_position = tilemap.local_to_map(player_local_position)
			
			# Anzahl der Layers
			var layers = tilemap.get_layers_count()
			
		# Überprüfen, ob der Spieler auf dieser TileMap ist
			for layer in range(layers):
				if tilemap.get_cell_source_id(layer, cell_position) != -1:
					found_tilemaps.append(tilemap)
					break
	
	if found_tilemaps.size() > 0:
			for tmap in found_tilemaps:
				print("Spieler befindet sich auf TileMap: ", tmap.name)
	else:
		print("Spieler befindet sich auf keiner TileMap.")
