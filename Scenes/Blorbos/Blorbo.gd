extends KinematicBody2D
class_name Blorbo

# References
onready var ray: RayCast2D = $RayCast2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var tween: Tween = $Tween

# Movement
var grid_size = 64
var input_directions = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}
var moving = false

# Colors
export (String)  var current_color = 'red' setget set_color
var red_spritesheet = preload('res://Scenes/Blorbos/Sprites/BlorboRed-Sheet.png')
var blue_spritesheet = preload('res://Scenes/Blorbos/Sprites/BlorboBlue-Sheet.png')





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("tile_clicked", self, 'handle_tile_click')
	set_color('red')


func spawn(color:String, final_position:Vector2, height_at_top:float) -> void:
	set_color(color)
	animation.play('red_drop')
	tween.interpolate_property(self, 'global_position:y', height_at_top, final_position, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	tween.start()
	yield(tween, "tween_completed")
	animation.play('red_spawn')
	

# ---------------------------------------
# ------------- MOVEMENT ----------------
# ---------------------------------------
func _unhandled_input(event: InputEvent) -> void:
	for dir in input_directions.keys():
		if event.is_action_pressed(dir):
			var direction: Vector2 = input_directions[dir]
			move(direction)


func move(direction: Vector2, last_movement: bool = true)->bool:
	if not moving:
		var destination_vector: Vector2 = direction * grid_size
		ray.cast_to = destination_vector
		ray.force_raycast_update()
		if not ray.is_colliding() and not moving:
			animation.stop()
			tween.stop_all()
			moving = true
			
			# Animation
			match direction:
				Vector2.RIGHT:
					$Sprite.flip_h = false
					animation.play(current_color+"_hop_right")
					var move_for = 0.3
					var delay = 0.1
					animate_position(direction, move_for, delay)
				Vector2.LEFT:
					$Sprite.flip_h = true
					animation.play(current_color+"_hop_right")
					var move_for = 0.3
					var delay = 0.1
					animate_position(direction, move_for, delay)
				Vector2.DOWN:
					var move_for = 0.3
					var delay = 0.1
					animation.play(current_color+"_hop_down")
					animate_position(direction)
				Vector2.UP:
					# Change with up animation
					animate_position(direction)
					animation.play(current_color+"_hop_up")
			yield(get_tree().create_timer(0.4), "timeout")
			moving = false
		if last_movement:
			animation.play(current_color+"_idle")
		# Moved
		return true
	# Not moved
	return false

func animate_position(direction: Vector2, seconds_spent_moving: float = 0.3, delay: float = 0)->void:
	var start_position: int
	var final_position: int
	var property_to_animate: String
	match direction:
		Vector2.RIGHT:
			start_position = position.x
			final_position = position.x + grid_size
			property_to_animate = 'position:x'
		Vector2.LEFT:
			start_position = position.x
			final_position = position.x - grid_size
			property_to_animate = 'position:x'
		Vector2.UP:
			start_position = position.y
			final_position = position.y - grid_size
			property_to_animate = 'position:y'
		Vector2.DOWN:
			start_position = position.y
			final_position = position.y + grid_size
			property_to_animate = 'position:y'
	
	tween.interpolate_property(self, property_to_animate, start_position, final_position, seconds_spent_moving, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
	tween.start()


# -----------------------------
# --------- COLOR -------------
# -----------------------------

func set_color(new_color:String):
	current_color = new_color
	
	match current_color:
		'blue':
			$Sprite.texture = blue_spritesheet
			$Sprite.hframes = 17
			animation.play("blue_idle")
		'red':
			$Sprite.texture = red_spritesheet
			$Sprite.hframes = 47
			animation.play("red_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
