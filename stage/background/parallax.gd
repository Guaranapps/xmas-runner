tool extends ParallaxBackground

#same value as player.ground_y
export var ground_y=500 setget set_ground_y

onready var ground_node=get_node("layer_foreground/ground")

func _ready():
	set_ground_y(ground_y)

func set_ground_y(y):
	ground_y=y
	if(ground_node!=null):
		var pos=ground_node.get_pos()
		pos.y=y
		ground_node.set_pos(pos)
