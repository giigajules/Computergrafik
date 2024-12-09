extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTSPEED = 5.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_key_pressed(KEY_W):
		position.x -= SPEED * delta * sin(rotation.y)
		position.z -= SPEED * delta * cos(rotation.y)
	if Input.is_key_pressed(KEY_S):
		position.x += SPEED * delta * sin(rotation.y)
		position.z += SPEED * delta * cos(rotation.y)
	if Input.is_key_pressed(KEY_A):
		rotation.y += ROTSPEED * delta
	if Input.is_key_pressed(KEY_D):
		rotation.y -= ROTSPEED * delta

	move_and_slide()


func _on_area_3d_body_entered(body: CharacterBody3D):
	print("Character entered the area!")
