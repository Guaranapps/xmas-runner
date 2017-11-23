extends Label

signal on_start

onready var best_score_node=get_node("best_score")
onready var animator=get_node("AnimationPlayer")
onready var ok_button=get_node("ok_button")

func _ready():
	#Refresh best score
	best_score_node.set_text(str(Game.get_best_score()))

#ok_button pressed callback
func _on_ok_button_pressed():
	ok_button.set_disabled(true)
	animator.play("disappear")
	emit_signal("on_start")

