extends Area2D

@onready var game_manager: Node = get_node("/root/Game/GameManager")
@onready var crush: AudioStreamPlayer = $crush


func _on_body_entered(body: Node2D) -> void:
	print("Rock got you")
	crush.play()
	get_child(1).queue_free()
	game_manager.player_hit()
	get_child(2).pause()
