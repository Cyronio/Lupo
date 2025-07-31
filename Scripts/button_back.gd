extends Button

@onready var game_manager: Node = get_node("/root/Game/GameManager")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		_on_pressed()


func _on_pressed() -> void:
	game_manager.reload_game()
