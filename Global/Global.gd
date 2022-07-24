extends Node

var moving := false 
var current_blorbos := [
#	{
#		'scene': blorbo,
#		'moving': false
#	}
]

signal move_all_blorbos(direction)
signal jump_into_palette(blorbo)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func new_blorbo(blorbo:Blorbo)->void:
	current_blorbos.append({
		'scene': blorbo,
		'moving': false
	})

# --- MOVEMENT ---
func move_all_blorbos(direction: Vector2)->void:
	if not moving:
		moving = true
		# Record that all blorbos should be moving
		for blorbo in current_blorbos:
			blorbo.moving = true
		emit_signal("move_all_blorbos", direction)

func finished_moving(blorbo:Blorbo)->void:
	for blorbo_dict in current_blorbos:
		if blorbo_dict.scene == blorbo:
			blorbo_dict.moving = false
	
	update_global_moving()

func update_global_moving()->void:
	var currently_moving = false
	for blorbo in current_blorbos:
		if blorbo.moving == true:
			currently_moving = true
			break
	
	moving = currently_moving

func jump_into_palette(blorbo:Blorbo)->void:
	emit_signal("jump_into_palette", blorbo)




# ------------------------------
# ------ TILE BASED CLICK ------
# ------------------------------

#signal tile_clicked(position)
#signal find_path(node_name, initial_position, final_position)
#signal path_detected(node_name, path)
#
#var bodies := [] setget add_to_bodies
#var positions_next_turn : PoolVector2Array = []

#func tile_clicked(position:Vector2)->void:
#	emit_signal("tile_clicked", position)
#
#func find_path(node_name:String, initial_position:Vector2, final_position: Vector2)->void:
#	emit_signal("find_path", node_name, initial_position, final_position)
#
#func path_detected(node_name:String, path: PoolVector2Array)->void:
#	emit_signal("path_detected", node_name, path)
#
#func add_to_bodies(body)->void:
#	bodies.append(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
