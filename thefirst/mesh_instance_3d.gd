extends MeshInstance3D

@export var segments = 6
@export var height = 2
@export var radius = 1

func _ready():
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_cap(height / 2, Vector3(0, 1, 0), 1, 0))
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_cap(-height / 2, Vector3(0, -1, 0), 0, 1))
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_sides())
	self.mesh = mesh

func create_cap(y_offset: float, normal: Vector3, rot: int, rot2: int):
	var surface_array_cap = []
	surface_array_cap.resize(Mesh.ARRAY_MAX)
	var verts_cap = PackedVector3Array()
	var norms_cap = PackedVector3Array()
	var index_cap = PackedInt32Array()
	var alpha = 2*PI / segments
	
	verts_cap.push_back(Vector3(0, y_offset, 0))
	norms_cap.push_back(Vector3(normal))
	
	for n in range(segments):
		var x = radius * cos(n * alpha)
		var z = radius * sin(n * alpha)
		verts_cap.push_back(Vector3(x, y_offset, z))
		norms_cap.push_back(normal)
		
		if n > 0:
			index_cap.push_back(0)
			index_cap.push_back(n+rot2)
			index_cap.push_back(n+rot)

	index_cap.push_back(segments)
	index_cap.push_back(rot)
	index_cap.push_back(rot2)
	
	surface_array_cap[Mesh.ARRAY_VERTEX] = verts_cap
	surface_array_cap[Mesh.ARRAY_NORMAL] = norms_cap
	surface_array_cap[Mesh.ARRAY_INDEX]  = index_cap
	
	return surface_array_cap

func create_sides():
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	
	var verts_sides = PackedVector3Array()
	var norms_sides = PackedVector3Array()
	var index_sides = PackedInt32Array()
	var alpha = 2 * PI / segments
	
	for n in range(segments):
		var x1 = radius * cos(n * alpha)
		var z1 = radius * sin(n * alpha)
		var x2 = radius * cos((n+1) * alpha)
		var z2 = radius * sin((n+1) * alpha)
		
		var top1 = Vector3(x1, height / 2, z1)
		var top2 = Vector3(x1, -height / 2, z1)
		var bottom1 = Vector3(x2, height / 2, z2)
		var bottom2 = Vector3(x2, -height / 2, z2)
		
		var normal1 = Vector3(x1, 0, z1).normalized()
		var normal2 = Vector3(x2, 0, z2).normalized()
		
		verts_sides.push_back(top1)
		norms_sides.push_back(normal1)
		
		verts_sides.push_back(bottom1)
		norms_sides.push_back(normal1)
		
		verts_sides.push_back(top2)
		norms_sides.push_back(normal2)
		
		verts_sides.push_back(bottom2)
		norms_sides.push_back(normal2)
		
		var base_index = n * 4
		index_sides.push_back(base_index)
		index_sides.push_back(base_index + 2)
		index_sides.push_back(base_index + 1)
		
		index_sides.push_back(base_index + 3)
		index_sides.push_back(base_index + 1)
		index_sides.push_back(base_index + 2)
		
	surface_array[Mesh.ARRAY_VERTEX] = verts_sides
	surface_array[Mesh.ARRAY_NORMAL] = norms_sides
	surface_array[Mesh.ARRAY_INDEX] = index_sides

	return surface_array

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation.y += PI * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= PI * delta
	if Input.is_action_pressed("ui_up"):
		rotation.x += PI * delta
	if Input.is_action_pressed("ui_down"):
		rotation.x -= PI * delta
