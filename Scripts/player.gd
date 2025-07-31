extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -250.0

@onready var game_manager: Node = get_node("/root/Game/GameManager")
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var double_right: AnimatedSprite2D = $AnimatedSprite2D/Double_Right
@onready var double_left: AnimatedSprite2D = $AnimatedSprite2D/Double_Left
@onready var double_down: AnimatedSprite2D = $AnimatedSprite2D/Double_Down
@onready var double_up: AnimatedSprite2D = $AnimatedSprite2D/Double_Up

@onready var sprites : Array[AnimatedSprite2D] = [sprite, double_right, double_left, double_down, double_up]
var right_off = false
var left_off = false

func _physics_process(delta: float) -> void:
	
	if position.x > 144:
		position.x -= 288
	elif position.x < -144:
		position.x += 288
	
	if position.y > 81:
		position.y -= 162
	elif position.y < -81:
		position.y += 162
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and game_manager.game_running:
		velocity.y = JUMP_VELOCITY
		audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		for s in sprites:
			s.flip_h = false
	elif direction < 0:
		for s in sprites:
			s.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			for s in sprites:
				s.play("idle")
		else:
			for s in sprites:
				s.play("run")
	else:
		for s in sprites:
			s.play("jump")
	
	if direction and game_manager.game_running:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
