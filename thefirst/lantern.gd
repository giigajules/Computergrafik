extends RigidBody3D


# Called when the node enters the scene tree for the first time.
var is_touched = false
var move_speed = 100

func _on_area_body_entered(body):
	if body.name == $"../Player":
		is_touched = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_touched:
		position.y -= move_speed * delta
