extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, Godot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 5
	if Input.is_key_pressed(KEY_UP):
		position.z -= speed * delta
		print("Up")
	if Input.is_key_pressed(KEY_DOWN):
		position.z += speed * delta
		print("Down")
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= speed * delta
		print("Left")
	if Input.is_key_pressed(KEY_RIGHT):
		position.x += speed * delta
		print("Right")
