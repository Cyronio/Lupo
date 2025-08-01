extends Node

const MAX_LEVEL = 9

var game_running = true
var level_count = 0
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var hit_timer: Timer = $Hit_Timer

@onready var mask: Node = get_node("/root/Game/Maske")

@onready var cleared_timer: Timer = $Cleared_Timer

func reset_mask():
	mask.position.x = 26
	mask.position.y = 1
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next"):
		next_level()

func level_cleared():
	audio.play()
	print("Level cleared")
	game_running = false
	cleared_timer.start()
	
func next_level():
	level_count += 1
	var next_level
	if level_count > MAX_LEVEL:
		next_level = load("res://Scenes/EndScreen.tscn")
	else:
		next_level = load("res://Scenes/level_" + str(level_count) + ".tscn")
	var instance = next_level.instantiate()
	get_node("/root/Game").add_child(instance)
	get_node("/root/Game/Level" + str(level_count-1)).queue_free()
	reset_mask()
	
func reload_level():
	var current_level = get_node("/root/Game/Level" + str(level_count))
	current_level.queue_free()
	await current_level.tree_exited
	var next_level = load("res://Scenes/level_" + str(level_count) + ".tscn")
	var instance = next_level.instantiate()
	instance.name = "Level" + str(level_count)
	get_node("/root/Game").add_child(instance)
	game_running = true
	reset_mask()
	
	
	
func _on_cleared_timer_timeout() -> void:
	cleared_timer.stop()
	game_running = true
	#get_tree().reload_current_scene()
	#pick_up.play()
	level_count += 1
	var next_level
	if level_count > MAX_LEVEL:
		next_level = load("res://Scenes/EndScreen.tscn")
	else:
		next_level = load("res://Scenes/level_" + str(level_count) + ".tscn")
	var instance = next_level.instantiate()
	get_node("/root/Game").add_child(instance)
	get_node("/root/Game/Level" + str(level_count-1)).queue_free()
	cleared_timer.wait_time = 1.0
	reset_mask()
	
func reload_game():
	audio.play()
	print("Game restarted")
	var next_level = load("res://Scenes/level_0.tscn")
	var instance = next_level.instantiate()
	get_node("/root/Game").add_child(instance)
	get_node("/root/Game/EndScreen").queue_free()
	level_count = 0
	reset_mask()
	
func player_hit():
	game_running = false
	hit_timer.start()
	
	


func _on_hit_timer_timeout() -> void:
	hit_timer.stop()
	reload_level()
