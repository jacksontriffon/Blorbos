extends CanvasLayer

onready var animation: AnimationPlayer = $AnimationPlayer
var hovered := false
var input_directions = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# --- Listen for WASD or Arrows
func _unhandled_input(event: InputEvent) -> void:
	for dir in input_directions.keys():
		if event.is_action_pressed(dir):
			var direction: Vector2 = input_directions[dir]
			match direction:
				Vector2.UP:
					_on_Top_pressed()
				Vector2.LEFT:
					_on_Left_pressed()
				Vector2.DOWN:
					_on_Bottom_pressed()
				Vector2.RIGHT:
					_on_Right_pressed()

func hide_all_highlights()->void:
	$Control/Top.visible =false
	$Control/Top/SpeakerTop.visible = false
	$Control/Left.visible =false
	$Control/Left/SpeakerLeft.visible = false
	$Control/Bottom.visible =false
	$Control/Bottom/SpeakerBottom.visible =false
	$Control/Right.visible =false
	$Control/Right/SpeakerRight.visible =false


# --- TOP ---
func _on_Top_pressed() -> void:
	$AnimationPlayer.play("click-top")
#	yield(animation, "animation_finished")
	Global.move_all_blorbos(Vector2.UP)
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")

func _on_Top_mouse_entered() -> void:
	$AnimationPlayer.play("fade-in-top")

func _on_Top_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("fade-in-top")
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")


# --- LEFT ---
func _on_Left_pressed() -> void:
	$AnimationPlayer.play("click-left")
	Global.move_all_blorbos(Vector2.LEFT)
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")

func _on_Left_mouse_entered() -> void:
	$AnimationPlayer.play("fade-in-left")

func _on_Left_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("fade-in-left")
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")


# --- BOTTOM ---
func _on_Bottom_pressed() -> void:
	$AnimationPlayer.play("click-bottom")
	Global.move_all_blorbos(Vector2.DOWN)
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")
	

func _on_Bottom_mouse_entered() -> void:
	$AnimationPlayer.play("fade-in-bottom")


func _on_Bottom_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("fade-in-bottom")
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")


# --- RIGHT ---
func _on_Right_pressed() -> void:
	$AnimationPlayer.play_backwards("click-right")
	Global.move_all_blorbos(Vector2.RIGHT)
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")

func _on_Right_mouse_entered() -> void:
	$AnimationPlayer.play("fade-in-right")

func _on_Right_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("fade-in-right")
	yield(animation, "animation_finished")
	$AnimationPlayer.play("RESET")




