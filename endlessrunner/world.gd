extends Node3D

@export var tiles: Array[PackedScene]
@export var tile_length = 20.0
@export var tile_rim = 5.0

var cur_tile_center = tile_length / 2
var cur_tile: RunnerTile
var last_tile: RunnerTile
var score = 0


func spawn_next_tile() -> Node3D:
	var tile_node = tiles.pick_random().instantiate()
	var player = $Player
	add_child(tile_node)
	#tile_node.obstacle_hit.connect(on_obstacle_hit)
	tile_node.slider_hit.connect(on_slider_hit)
	tile_node.points_earned.connect(on_points_earned)
	tile_node.failed.connect(on_failed)
	player.failed.connect(on_failed)
	cur_tile_center -= tile_length
	tile_node.position.z = cur_tile_center
	return tile_node


func kill_tile(tile: RunnerTile):
	#tile.obstacle_hit.disconnect(on_obstacle_hit)
	tile.points_earned.disconnect(on_points_earned)
	tile.failed.disconnect(on_failed)
	remove_child(tile)
	tile.queue_free()


#func on_obstacle_hit():
	#print("An obstacle was hit!")


func on_points_earned():
	score += 1
	print("You earned " + str(score) + " points!")
	
func on_failed():
	get_tree().reload_current_scene()
	
func on_slider_hit():
	pass



func _ready():
	cur_tile = spawn_next_tile()


func _process(delta):
	if $Player.position.z < cur_tile_center - tile_length/2 + tile_rim:
		if last_tile != null:
			kill_tile(last_tile)
		last_tile = cur_tile
		cur_tile = spawn_next_tile()
