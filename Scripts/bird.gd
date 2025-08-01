extends Area2D

@onready var game_manager: Node = get_node("/root/Game/GameManager")
@onready var caw: AudioStreamPlayer = $Caw

func _on_body_entered(body: Node2D) -> void:
	print("Bird got you")
	caw.play()
	get_child(1).queue_free()
	game_manager.player_hit()
	get_child(2).pause()
	
