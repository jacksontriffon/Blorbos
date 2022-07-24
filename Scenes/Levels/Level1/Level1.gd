extends Level


var initial_red_position = Vector2(960, 512)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Blobos/Red.spawn('red', initial_red_position, initial_red_position.y-64)
	


func get_camera_rect()->Vector2:
	return Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
