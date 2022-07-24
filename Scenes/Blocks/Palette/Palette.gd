extends StaticBody2D

# Nodes
onready var dimple_1: Sprite = $PaletteSprite/Dimple
onready var dimple_2: Sprite = $PaletteSprite/Dimple2
onready var dimple_3: Sprite = $PaletteSprite/Dimple3
onready var dimple_4: Sprite = $PaletteSprite/Dimple4
onready var dimples := [
	dimple_1,
	dimple_2,
	dimple_3,
	dimple_4,
]

# State
export (int) var dimples_filled := 0
export (int) var max_dimples := 1
export (String) var dimple_colour_1 := 'red'
export (String) var dimple_colour_2 : String
export (String) var dimple_colour_3 : String
export (String) var dimple_colour_4 : String
var just_spawned = true



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("position_1")
	hide_dimples()
	hide_all_paint()
	yield(get_tree().create_timer(1),"timeout")
	just_spawned = false
	

func hide_all_paint()->void:
	for dimple in dimples:
		dimple.get_node("Paint").visible = false

func hide_dimples()->void:
	# Hide all
	for dimple in dimples:
		dimple.visible = false
	
	# Show up to max_dimples
	for n in range(0, max_dimples, 1):
		dimples[n].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func fill_next_dimple_with_paint()->void:
	if dimples_filled < max_dimples and not just_spawned:
		var paint = dimples[dimples_filled].get_node("Paint")
		paint.visible = true
		dimples_filled += 1 
		# Only animate if palette isn't full
		if dimples_filled < max_dimples:
			yield(get_tree().create_timer(1), "timeout")
			var next_position_animation = 'position_'+str(dimples_filled + 1)
			$AnimationPlayer.play(next_position_animation)
		else:
			# Trigger LEVEL_COMPLETE!
			print('LEVEL COMPLETE!')
			pass


func _on_Area2D_body_entered(blorbo: Blorbo) -> void:
	if blorbo:
		blorbo.jump_into_palette(blorbo)
		yield(blorbo.animation, "animation_finished")
		fill_next_dimple_with_paint()








Nah...




















