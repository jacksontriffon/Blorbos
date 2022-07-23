extends Level


var initial_red_position = Vector2(896, 576)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Blobos/Red.global_position = initial_red_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
