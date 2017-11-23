extends Node2D

#when node go off screen memory is freed
func _on_visibility_notifier_exit_screen():
	queue_free()
