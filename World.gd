extends Node2D


var astar := AStar2D.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("find_path", self, 'get_nav_path')


func get_nav_path(node_name:String, initial_pos: Vector2, final_position:Vector2)->PoolVector2Array:
	var path: PoolVector2Array = $Navigation2D.get_simple_path(initial_pos, final_position)
	Global.path_detected(node_name, path)
	
	return path

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
