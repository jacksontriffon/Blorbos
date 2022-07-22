extends KinematicBody2D
class_name Blorbo

# References
onready var ray: RayCast2D = $RayCast2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var tween: Tween = $Tween

# Variables
var grid_size = 64
var input_directions = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}
export var color = 'red'
var moving = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(global_position)
	Player.connect("tile_clicked", self, 'handle_tile_click')


func _unhandled_input(event: InputEvent) -> void:
	for dir in input_directions.keys():
		if event.is_action_pressed(dir):
			var direction: Vector2 = input_directions[dir]
			move(direction)
	
	

func move(direction: Vector2, last_movement: bool = true)->void:
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
		#			Vector2.RIGHT:
		#				$Sprite.flip_h = false
		#				animation.play(color+'_hop')
		#				var seconds_left: float = animation.current_animation_length
		#				tween.interpolate_property(self, 'position:x', position.x, position.x + grid_size, seconds_left / 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		#				tween.start()
		#				yield(animation, "animation_finished")
				Vector2.RIGHT:
					$Sprite.flip_h = false
					animation.play(color+"_hop")
					var move_for = 0.3
					var delay = 0.1
					animate_position(direction, move_for, delay)
				Vector2.LEFT:
					$Sprite.flip_h = true
					animation.play(color+"_hop")
					var move_for = 0.3
					var delay = 0.1
					animate_position(direction, move_for, delay)
				Vector2.DOWN:
					# Change with down animation
					animation.play(color+"_hop")
					animate_position(direction)
				Vector2.UP:
					# Change with up animation
					animation.play(color+"_hop")
					animate_position(direction)
			
			yield(animation, "animation_finished")
			moving = false
				
		if last_movement:
			animation.play("red_idle")

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


func handle_tile_click(tile_position: Vector2)->void:
	print('Blorbo is going to ', tile_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
