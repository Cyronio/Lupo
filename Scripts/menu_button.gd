extends MenuButton

@onready var game_manager: Node = get_node("/root/Game/GameManager")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	game_manager.level_cleared()
