extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 150
@export var ACCELERATION: int = 300

@onready var sprite: AnimatedSprite2D = $sprite  # Path untuk node sprite
@onready var ray_cast: RayCast2D = $RayCast2D   # Path untuk node RayCast2D
@onready var timer = $Timer                     # Path untuk node Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var left_bounds: Vector2
var right_bounds: Vector2

enum States {
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _ready():
	# Atur batas kiri dan kanan untuk state WANDER
	left_bounds = self.position - Vector2(125, 0)
	right_bounds = self.position + Vector2(125, 0)
	# Debugging untuk memastikan node ditemukan
	print("Sprite initialized: ", sprite != null)
	print("Timer initialized: ", timer != null)
	print("RayCast2D initialized: ", ray_cast != null)

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:  # Chase state
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)

	move_and_slide()

func change_direction() -> void:
	if current_state == States.WANDER:
		if sprite.flip_h:  # Moving right
			if self.position.x < right_bounds.x:
				direction = Vector2(1, 0)
			else:
				# Flip to moving left
				sprite.flip_h = false
				ray_cast.target_position = Vector2(-125, 0)
		else:  # Moving left
			if self.position.x > left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				# Flip to moving right
				sprite.flip_h = true
				ray_cast.target_position = Vector2(125, 0)
	else:  # Chase state, follow the player				w
		direction = (player.position - self.position).normalized()
		direction.x = sign(direction.x)  # Adjust direction to -1 or 1 for X-axis

		if direction.x == 1:  # Flip to moving right
			sprite.flip_h = true
			ray_cast.target_position = Vector2(125, 0)
		else:  # Flip to moving left
			sprite.flip_h = false
			ray_cast.target_position = Vector2(-125, 0)

func look_for_player() -> void:
	if ray_cast != null and ray_cast.is_colliding():  # Pastikan ray_cast tidak null
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player() -> void:
	timer.stop()
	current_state = States.CHASE

func stop_chase() -> void:
	if timer.time_left <= 0:
		timer.start()
		current_state = States.WANDER

func _on_timer_timeout() -> void:
	current_state = States.WANDER
