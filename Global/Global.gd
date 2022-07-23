extends Node

signal tile_clicked(position)
signal find_path(node_name, initial_position, final_position)
signal path_detected(node_name, path)

var bodies := [] setget add_to_bodies
var positions_next_turn : PoolVector2Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func tile_clicked(position:Vector2)->void:
	emit_signal("tile_clicked", position)

func find_path(node_name:String, initial_position:Vector2, final_position: Vector2)->void:
	emit_signal("find_path", node_name, initial_position, final_position)

func path_detected(node_name:String, path: PoolVector2Array)->void:
	emit_signal("path_detected", node_name, path)

func add_to_bodies(body)->void:
	bodies.append(body)
	print(bodies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
