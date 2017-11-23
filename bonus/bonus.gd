extends "res://core/spawnable.gd"

export var min_y=200
export var max_y=450
export var value=5

onready var animator=get_node("bonus/AnimationPlayer")
var _taken=false

#virtual fonction of spawnable (core/spawnable.gd) to generate random settings
#called in spawn scene before adding node to scene
func randomize_settings():
	var pos=get_pos()
	pos.y=rand_range(min_y,max_y)
	set_pos(pos)

#bonus body_enter callback
func _on_bonus_body_enter( body ):
	#using group to identify player node (see player/player.tscn scene groups)
	if(!_taken and body.is_in_group("player")):
		_taken=true
		animator.play("taken")
		Game.inc_score(value)
