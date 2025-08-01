extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -250.0
@onready var camera: Camera2D = %Camera2D

@onready var game_manager: Node = get_node("/root/Game/GameManager")

@onready var mask: Node = get_node("/root/Game/Maske")

@onready var coyote_timer: Timer = $CoyoteTimer


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var double_right: AnimatedSprite2D = $AnimatedSprite2D/Double_Right
@onready var double_left: AnimatedSprite2D = $AnimatedSprite2D/Double_Left
@onready var double_down: AnimatedSprite2D = $AnimatedSprite2D/Double_Down
@onready var double_up: AnimatedSprite2D = $AnimatedSprite2D/Double_Up

@onready var sprites : Array[AnimatedSprite2D] = [sprite, double_right, double_left, double_down, double_up]

var can_jump = true

func jump():
	velocity.y = JUMP_VELOCITY
	audio.play()
	can_jump = false
	
func _physics_process(delta: float) -> void:
	
	if position.x > 432:
		position.x -= 576
	elif position.x < -144:
		position.x += 576
	
	if position.y > 81:
		position.y -= 324
	elif position.y < -234:
		position.y += 324
		
	if position.x > 144 or position.x < -144:
		camera.position.x = 288
		mask.position.x = 314
	else: 
		camera.position.x = 0
		mask.position.x = 26
	
	if position.y > 81 or position.y < -81:
		camera.position.y = -161
		mask.position.y = -160
	else:
		camera.position.y = -1
		mask.position.y = 1
	
	if can_jump == false and is_on_floor():
		can_jump = true
	
	if !is_on_floor() and can_jump and coyote_timer.is_stopped():
		coyote_timer.start()
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump and game_manager.game_running:
		jump()

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


func _on_coyote_timer_timeout() -> void:
	can_jump = false
