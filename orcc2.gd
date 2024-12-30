

extends CharacterBody2D


class_name orcc2
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var ray_castkanan = $RayCastkanan

@onready var ray_castkiri = $RayCastkiri

const speed = 30
var is_orc_chase: bool

var health = 80
var health_max= 80
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var  damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = 200
var is_roaming: bool = true

var direction = 1

var target_position: Vector2

enum States {
	WANDER,
	CHASE
}
var current_state = States.WANDER

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	move_and_slide()
	
	if ray_castkanan.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_castkiri.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	position.x += direction * speed * delta
	

func move(delta):
	if !dead:
		if is_orc_chase:
			velocity += dir * speed * delta
		else:
			# Orc is roaming and changing direction
			velocity.x = dir.x * speed
		is_roaming = true
	elif dead:
		velocity.x = 0


func _on_direction_timer_timeout():
	$DirectionTimer.wait_time = choose([!0])
	if!is_orc_chase:
		dir =choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0	
func choose(array):
	array.shuffle()
	return array.front()


func _on_area_2d_body_entered(body):
	if (body.name == "animated_sprite_2d"):
		var y_delta = position.y - body.position.y
		print("pantekk")
