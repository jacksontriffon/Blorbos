extends Node2D

var initial_red_position := Vector2(832, 64)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Blorbo.spawn('red', initial_red_position, initial_red_position.y-64)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
