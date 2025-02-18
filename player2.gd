extends CharacterBody2D
class_name Player2

var screen_size
#@onready var active_manager = get_parent()
@export var speed = 400
@export var jump_impulse = 1000
var jump_count = 0
var fall_acceleration = 25
#var is_active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#var is_active = active_manager.get("active")
	
	var velocity = Vector2.ZERO # The player's movement vector.
		
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#if Input.is_action_pressed("fast_fall"):
			#fall_acceleration = 50
			#print("falling faster?")
		#else:
		fall_acceleration = 25
		velocity.y += fall_acceleration 
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_impulse
			jump_count += 1
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_slide()
