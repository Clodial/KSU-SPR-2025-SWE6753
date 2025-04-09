extends CharacterBody2D
class_name Player

signal enemy_collision
signal lost_life

var screen_size
@export var speed = 400
@export var jump_impulse = 700
@export var fast_fall = 100
@export var fall_acceleration = 30
@export var terminal_gravity = 500
@onready var coyote_time = $CoyoteTime
@export var playerOne = true
@export var push_force: float = 200.0
var coyote_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	coyote_check = false
	if(playerOne):
		$PlayerAnimation.play("p1_idle")
	else:
		$PlayerAnimation.play("p2_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_jump()
	handle_movement(delta)
	var collision_count = move_and_slide()
	if collision_count:
		for i in get_slide_collision_count():
			var collision = self.get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is RigidBody2D:
				collider.apply_central_impulse(-collision.get_normal() * push_force)
			
	
func handle_jump() -> void:
	if !is_on_floor():
		# animation stuff
		if velocity.y < 0:
			if(playerOne):
				$PlayerAnimation.play("p1_jump")
			else:
				$PlayerAnimation.play("p2_jump")
		else:
			if(playerOne):
				$PlayerAnimation.play("p1_fall")
			else:
				$PlayerAnimation.play("p2_fall")
		if coyote_time.time_left == 0 && coyote_check == false:
			coyote_time.start()
			coyote_check = true
		if !coyote_time.is_stopped() && Input.is_action_just_pressed("jump"):
				velocity.y -= jump_impulse
		velocity.y += fall_acceleration
		if  velocity.y > terminal_gravity:
			velocity.y = terminal_gravity
		if Input.is_action_just_released("jump") and velocity.y < -fast_fall:
			velocity.y = -fast_fall 
	else:
		coyote_check = false
		if Input.is_action_just_pressed("jump"):
			velocity.y -= jump_impulse
			coyote_check = true
		
func handle_movement(delta) -> void:
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	if velocity.x != 0:
		if is_on_floor():
			if(playerOne):
				$PlayerAnimation.play("p1_walk")
			else:
				$PlayerAnimation.play("p2_walk")
		$PlayerAnimation.flip_h = velocity.x < 0
	else:
		if is_on_floor():
			if(playerOne):
				$PlayerAnimation.play("p1_idle")
			else:
				$PlayerAnimation.play("p2_idle")
	if horizontal_direction:
		velocity.x = speed * horizontal_direction
	elif not horizontal_direction:
		velocity.x = move_toward(velocity.x, 0, speed * 0.5) #gradual deceleration when not sliding
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("yolios")
		enemy_collision.emit();
		lost_life.emit();
		
