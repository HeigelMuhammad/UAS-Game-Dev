extends CharacterBody2D


const SPEED = 340.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

@onready var attacking = false 

func _process(delta):
	if Input.is_action_just_pressed("serang"):
		attack()

func attack():
	attacking = true
	animated_sprite.play("attacking")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("lompat") and is_on_floor():
		$AudioStreamPlayer.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction: 1, -1, 0
	var direction = Input.get_axis("gerak_kiri", "gerak_kanan")
	
	#flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction< 0 :
		animated_sprite.flip_h = true
	
	#play animation
	if !attacking:
		if is_on_floor():
			if direction == 0 :
				animated_sprite.play("idle")
				
			else :
				animated_sprite.play("run")
				
		else :
			animated_sprite.play("jump")
			
	
	#attack
	if Input.is_action_just_pressed("serang"):
		$AudioStreamPlayer2.play()
		if direction == 0 :
				animated_sprite.play("attacking")
		else :
				animated_sprite.play("run")
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_btn_stage_2_pressed():
	get_tree().change_scene_to_file("res://stage3.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scene/Main Menu.tscn")
