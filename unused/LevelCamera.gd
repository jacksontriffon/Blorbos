extends Camera2D


var moving := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if not moving and event is InputEventMouse:
		# Click or tap
		if event is InputEventMouseButton:
			print('click ', event.position)
		
		if event is InputEventMouseMotion:
			var hover_margin = 30
			# Hover Left Edge
			if event.position.x < hover_margin:
				print('hover on ', event.position)
			# Hover Right Edge
			elif event.position.x > get_viewport_rect().size.x - hover_margin:
				print('hover on ', event.position)
			# Hover Top Edge
			elif event.position.y < hover_margin:
				print('hover on ', event.position)
			# Hover Bottom Edge
			elif event.position.x > get_viewport_rect().size.y - hover_margin:
				print('hover on ', event.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
