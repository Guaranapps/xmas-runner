extends "res://core/spawnable.gd"

export(float,0,1,0.01) var min_scale=0.4
export(float,0,1,0.01) var max_scale=1

func randomize_settings():
	var scale=rand_range(min_scale,max_scale)
	set_scale(Vector2(scale,scale))
