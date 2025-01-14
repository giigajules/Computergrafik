extends CharacterBody3D


@export var SPEED = 10.0
const JUMP_VELOCITY = 4.5
signal failed
signal slider_hit

#func check():
	#var player = $Player
	#player.slider_hit.connect(on_slider_hit)

#func on_slider_hit():
	#SPEED = SPEED * 2
	#print("More speed!")


func _physics_process(delta: float) -> void:
	#check()
	velocity.z = -SPEED
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if position.y < 0:
		$LosingScreen.visible = true
		velocity.z = 0
		velocity.y = -5
		if position.y < -10:
			velocity.y = 0
			emit_signal("failed")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x += SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()
