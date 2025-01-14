extends StaticBody3D
class_name RunnerTile

signal obstacle_hit
signal points_earned
signal failed
signal slider_hit


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_coin_body_entered(body: Node3D) -> void:
	if body == $/root/World/Player:
		emit_signal("points_earned")


func _on_obstacle_1_body_entered(body: Node3D) -> void:
	if body == $/root/World/Player:
		emit_signal("failed")


func _on_slider_body_entered(body: Node3D) -> void:
	if body == $/root/World/Player:
		emit_signal("slider_hit")

#func _on_area_3d_body_exited(body: Node3D) -> void:
	#if body == $/root/World/Player:
		#emit_signal("failed")
