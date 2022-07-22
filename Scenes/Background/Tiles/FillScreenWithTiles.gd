tool
extends Node2D

var grid_size = 64
var tile_scene = preload("res://Scenes/Background/Tiles/Tile.tscn")
var aspect_ratio: Vector2 = Vector2(1280,720)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_number_of_tiles())
	_fill()

func _fill()->void:
	var total_tiles: Vector2 = get_number_of_tiles()
	for row_num in total_tiles.y:
		for column_num in total_tiles.x:
			var tile = tile_scene.instance()
			add_child(tile)
			tile.rect_global_position = Vector2(column_num * 64, row_num * 64)
			

func get_number_of_tiles()->Vector2:
	var rows: int = aspect_ratio.y / 64
	var columns: int = aspect_ratio.x / 64
	
	return Vector2(columns, rows)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
