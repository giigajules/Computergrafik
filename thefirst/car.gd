extends RigidBody3D

var SPEED = .01
var ACCELERATION = 1.03

func _physics_process(delta: float):
	if Input.is_key_pressed(KEY_C):
		position.z += SPEED
		SPEED = SPEED * ACCELERATION
