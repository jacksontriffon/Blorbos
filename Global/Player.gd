extends Node

signal tile_clicked(position)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func tile_clicked(position:Vector2)->void:
	emit_signal("tile_clicked", position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
