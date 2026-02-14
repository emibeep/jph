extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_time: Timer = $CoyoteTime

# -------------------------------------------------------------
# STATS
# -------------------------------------------------------------

signal stun_changed(new_value)
signal invincibility_changed(new_value)

@export var max_health = 100
@export var health = 100
@export var inv_time = 0.67
@export var is_invincible = false:
	get:
		return is_invincible
	set(value):
		if is_invincible != value:
			is_invincible = value
			invincibility_changed.emit(value)
@export var stunned = false:
	get:
		return stunned
	set(value):
		if stunned != value:
			stunned = value
			stun_changed.emit(value)

# -------------------------------------------------------------
# MOVEMENT
# -------------------------------------------------------------

const SPEED: float = 125.0
const JUMP_VELOCITY: float = -250.0

var can_jump : bool = true
var jumped : bool = false
var frames_since_input : int = 0 #this is for jump input
var jump_buffer_frames : int = 5

func _on_coyote_time_timeout() -> void:
	can_jump = false


func jump() -> void:
	if stunned:
		return
	velocity.y = JUMP_VELOCITY
	coyote_time.stop()
	can_jump = false


func _physics_process(delta: float) -> void:
	# JUMP
	if not is_on_floor():
		velocity += get_gravity() * delta
		if can_jump and coyote_time.is_stopped():
			coyote_time.start()
	else:
		can_jump = true
	
	if Input.is_action_just_pressed("jump"):
		jumped = true
		
	if jumped:
		frames_since_input += 1

	if frames_since_input >= jump_buffer_frames:
		jumped = false
		frames_since_input = 0
	
	if jumped and can_jump:
		jumped = false
		frames_since_input = 0 
		jump()
	
	# HORIZONTAL
	var direction := Input.get_axis("move_left", "move_right")
	if stunned:
		direction = 0
	if direction:
		animated_sprite_2d.flip_h = sign(direction) == -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED *0.1)

	move_and_slide()
