extends Button


var empty_style = preload('res://Scenes/Background/Tiles/Themes/Active/disabled.tres')
var non_clickable_style = preload('res://Scenes/Background/Tiles/Themes/Deactivated/disabled_and_hovered.tres')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# --- Disable tiles after click ~ until everything stopped moving ---
#	Player.connect("tile_clicked", self, '_disable_briefly')

#func _disable_briefly(position:Vector2)->void:
#	# Change hover & focus themes to greyed out
#	disabled = true
#	yield(get_tree().create_timer(2),"timeout")
#	disabled = false

#func _on_Tile_mouse_entered() -> void:
#	if disabled:
#		print('tile disabled at ', get_global_rect().position)
#		add_stylebox_override('disabled', non_clickable_style)


func _on_Tile_pressed() -> void:
	# Emit position when clicked
	Global.tile_clicked(get_global_rect().position)

func _on_Tile_mouse_exited() -> void:
	# Prevent focus when mouse isn't on tile
	if focus_mode:
		focus_mode = false
	
#	if disabled:
#		add_stylebox_override('disabled', empty_style)
#
#


func _on_Area2D_body_entered(body: Node) -> void:
	print(body.get_position_in_parent())
