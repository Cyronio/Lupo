extends Node

var game_running = true

@onready var cleared_timer: Timer = $Cleared_Timer

func level_cleared():
	print("Level cleared")
	game_running = false
	cleared_timer.start()
	
	


func _on_cleared_timer_timeout() -> void:
	game_running = true
	get_tree().reload_current_scene()
