extends KinematicBody2D
class_name Blorbo

# References
onready var ray: RayCast2D = $RayCast2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var tween: Tween = $Tween

# Movement
var grid_size := 64
var collided := false


# Colors
export (String)  var current_color = 'red' setget set_color
var red_spritesheet = preload('res://Scenes/Blorbos/Sprites/BlorboRed-Sheet.png')
var blue_spritesheet = preload('res://Scenes/Blorbos/Sprites/BlorboBlue-Sheet.png')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("move_all_blorbos", self, 'react_to_call')
	Global.connect("jump_into_palette", self, 'jump_into_palette')

func spawn(color:String, final_position:Vector2, height_at_top:float) -> void:
	Global.new_blorbo(self)
	global_position.x = final_position.x
	set_color(color)
	animation.play('drop')
	tween.interpolate_property(self, 'global_position:y', height_at_top, final_position.y, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	tween.start()
	yield(tween, "tween_completed")
	animation.play('spawn')
	yield(animation, "animation_finished")
	animation.play('idle')

func jump_into_palette(blorbo:Blorbo)->void:
	if blorbo == self:
		animation.play('into_palette')
#	yield(animation, "animation_finished")
#	queue_free()

# ---------------------------------------
# ------------- MOVEMENT ----------------
# ---------------------------------------

func react_to_call(direction:Vector2)->void:
	match current_color:
		'red':
			ray.cast_to = direction * 1000
			ray.force_raycast_update()
			var collider: StaticBody2D = ray.get_collider()
			var steps_until_collision = 0
			match direction:
				Vector2.UP:
					steps_until_collision = (position.y - collider.global_position.y) / grid_size
				Vector2.LEFT:
					steps_until_collision = (position.x - collider.global_position.x) / grid_size
				Vector2.DOWN:
					steps_until_collision = (collider.global_position.y - position.y) / grid_size
#					steps_until_collision -= 1
				Vector2.RIGHT:
					steps_until_collision = (collider.global_position.x - position.x) / grid_size
#					steps_until_collision -= 1
			print(steps_until_collision, ' steps | ', 'current_position ', global_position, ' | collider_position ', collider.global_position )
			for n in steps_until_collision:
				move(direction)
				yield(animation, "animation_finished")
		'blue':
			pass
		'purple':
			pass
	
	Global.finished_moving(self)




func move(direction: Vector2, last_movement: bool = true)->void:
	var destination_vector: Vector2 = direction * grid_size
	ray.cast_to = destination_vector
	ray.force_raycast_update()
	if not ray.is_colliding():
		animation.stop()
		tween.stop_all()
		
		# Animation
		match direction:
			Vector2.RIGHT:
				$Sprite.flip_h = false
				animation.play("hop_right")
				animate_position(direction)
			Vector2.LEFT:
				$Sprite.flip_h = true
				animation.play("hop_right")
				animate_position(direction)
			Vector2.DOWN:
				animation.play("hop_down")
				animate_position(direction)
			Vector2.UP:
				animate_position(direction)
				animation.play("hop_up")
		yield(animation, "animation_finished")
	# About to collide
	else:
		animation.stop()
		tween.stop_all()
		match direction:
			Vector2.RIGHT:
				$Sprite.flip_h = false
				animation.play("bump_right")
			Vector2.LEFT:
				$Sprite.flip_h = true
				animation.play("bump_right")
			Vector2.DOWN:
				animation.play("bump_down")
			Vector2.UP:
				animation.play("bump_up")
		yield(animation, "animation_finished")
		collided = true
	
	if last_movement:
		animation.play("idle")

func animate_position(direction: Vector2, seconds_spent_moving: float = 0.3, delay: float = 0.1)->void:
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
			$Sprite.hframes = 57
			animation.play("idle")
		'red':
			$Sprite.texture = red_spritesheet
			$Sprite.hframes = 91
			animation.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
