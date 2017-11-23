extends Node2D

onready var gameover_dialog=get_node("HUD/gameover_dialog")
onready var timer_node=get_node("score_timer")
onready var player_node=get_node("player")
onready var parallax_node=get_node("parallax")

#define score gain per seconds
export var speed_inc=10

func _ready():
	#Game is a singleton (see Autoload scene in project parameters)
	Game.reset_score()
	if(Game.skip_ready):
		#Ready node is only use for the first launch
		get_node("HUD/ready").queue_free()
		#Callback used when confirm on "HUD/ready" node (see on_start signal connection)
		_on_ready_on_start()

#player on_dead signal callback
func _on_player_on_dead():
	timer_node.stop()
	Game.refresh_best_score()
	gameover_dialog.popup_centered()

#score_timer timeout signal callback
func _on_score_timer_timeout():
	Game.inc_score()
	player_node.run_speed+=speed_inc

#HUD/ready on_start signal callback
func _on_ready_on_start():
	player_node.run()
	timer_node.start()
