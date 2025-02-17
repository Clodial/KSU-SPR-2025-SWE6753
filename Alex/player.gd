extends CharacterBody2D
class_name Player

var screen_size
@export var speed = 400
@export var jump_impulse = 1000
@export var fast_fall = 50
@export var fall_acceleration = 25
@export var terminal_gravity = 400
@onready var coyote_time = $CoyoteTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#var velocity = Vector2.ZERO # The player's movement vector.
		
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		velocity.y += fall_acceleration
		if  velocity.y > terminal_gravity:
			velocity.y = terminal_gravity
		if Input.is_action_just_released("jump") and velocity.y < -fast_fall or !coyote_time.is_stopped():
			velocity.y = -fast_fall 
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y -= jump_impulse
		
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed 
		
	if is_on_floor():
		coyote_time.start()
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
