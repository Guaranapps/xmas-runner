extends "res://core/spawnable.gd"

export var min_y=400
export var max_y=450

func randomize_settings():
	var pos=get_pos()
	pos.y=rand_range(min_y,max_y)
	set_pos(pos)
