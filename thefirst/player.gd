extends Node3D


# Called when the node enters the scene tree for the first time.
const SPEED = 5.0
const JUMP_VELOCITY = 4.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui-down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).norma
	if direction:																		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
