extends PopupDialog

onready var score_node=get_node("score")
onready var best_score_node=get_node("best_score")
onready var animator=get_node("AnimationPlayer")

#about_to_show callback
func _on_dead_dialog_about_to_show():
	#Get current score
	score_node.set_text(str(Game.get_score()))
	#Get best score
	best_score_node.set_text(str(Game.get_best_score()))
	#Animation manage opacity appear with a delay
	animator.play("appear")

#retry pressed callback
func _on_retry_pressed():
	Game.skip_ready=true
	get_tree().reload_current_scene()

#quit pressed callback
func _on_quit_pressed():
	get_tree().quit()
