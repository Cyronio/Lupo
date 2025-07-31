extends Area2D

@onready var game_manager: Node = get_node("/root/Game/GameManager")


func _on_body_entered(body: Node2D) -> void:
	print("Meat picked up")
	game_manager.level_cleared()
	queue_free()
	
