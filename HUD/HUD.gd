extends CanvasLayer

onready var score_node=get_node("score")

func _ready():
	Game.connect("on_score_update",self,"_on_score_update")
	
#Game singleton on_score_update callback
func _on_score_update(score):
	score_node.set_text(str(score))

#pause pressed callback
func _on_pause_pressed():
	get_tree().set_pause(!get_tree().is_paused())
