extends Node

var game_running = true
var level_count = 0
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var cleared_timer: Timer = $Cleared_Timer

func level_cleared():
	audio.play()
	print("Level cleared")
	game_running = false
	cleared_timer.start()
	
	


func _on_cleared_timer_timeout() -> void:
	cleared_timer.stop()
	game_running = true
	#get_tree().reload_current_scene()
	#pick_up.play()
	level_count += 1
	var next_level = load("res://Scenes/level_" + str(level_count) + ".tscn")
	var instance = next_level.instantiate()
	get_node("/root/Game").add_child(instance)
	get_node("/root/Game/Level" + str(level_count-1)).queue_free()
	cleared_timer.wait_time = 1.0
	
func reload_game():
	audio.play()
	print("Game restarted")
	var next_level = load("res://Scenes/level_0.tscn")
	var instance = next_level.instantiate()
	get_node("/root/Game").add_child(instance)
	get_node("/root/Game/Level" + str(level_count)).queue_free()
	level_count = 0
	
