extends MeshInstance3D

@export var segments = 12  
@export var height = 2.0  
@export var radius = 1.0  
@export var slices = 3     
@export var belly_thickness = .2

func _ready():
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_barrel())
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_cap(-height / 2, -1))  # Bottom cap
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, create_cap(height / 2, 1))   # Top cap
	self.mesh = mesh

func create_barrel():
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	
	var verts = PackedVector3Array()
	var norms = PackedVector3Array()
	var indices = PackedInt32Array()
	var alpha = 2 * PI / segments
	var slice_height = height / slices
	
	for i in range(slices + 1):
		var y = -height / 2 + i * slice_height  
		var t = float(i) / slices               
		
		var current_radius = radius + belly_thickness * sin(t * PI)
		
		for n in range(segments):
			var x = current_radius * cos(n * alpha)
			var z = current_radius * sin(n * alpha)
			
			verts.push_back(Vector3(x, y, z))
			norms.push_back(Vector3(x, 0, z).normalized())
	
	for i in range(slices):
		for n in range(segments):
			var current = i * segments + n
			var next = current + 1 if (n + 1) < segments else i * segments
			
			var above = current + segments
			var above_next = above + 1 if (n + 1) < segments else (i + 1) * segments
			
			indices.push_back(current)
			indices.push_back(next)
			indices.push_back(above)
			
			indices.push_back(next)
			indices.push_back(above_next)
			indices.push_back(above)
	
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_NORMAL] = norms
	surface_array[Mesh.ARRAY_INDEX] = indices
	
	return surface_array

func create_cap(y_offset: float, normal_dir: float):
	var surface_array_cap = []
	surface_array_cap.resize(Mesh.ARRAY_MAX)
	
	var verts_cap = PackedVector3Array()
	var norms_cap = PackedVector3Array()
	var index_cap = PackedInt32Array()
	var alpha = 2 * PI / segments
	
	verts_cap.push_back(Vector3(0, y_offset, 0))
	norms_cap.push_back(Vector3(0, normal_dir, 0))

	for n in range(segments):
		var x = radius * cos(n * alpha)
		var z = radius * sin(n * alpha)
		verts_cap.push_back(Vector3(x, y_offset, z))
		norms_cap.push_back(Vector3(0, normal_dir, 0))
	
	for n in range(segments):
		var next = n + 1 if (n + 1) < segments else 0
		if normal_dir > 0:
			index_cap.push_back(0)
			index_cap.push_back(n + 1)
			index_cap.push_back(next + 1)
		else:
			index_cap.push_back(0)
			index_cap.push_back(next + 1)
			index_cap.push_back(n + 1)
	
	surface_array_cap[Mesh.ARRAY_VERTEX] = verts_cap
	surface_array_cap[Mesh.ARRAY_NORMAL] = norms_cap
	surface_array_cap[Mesh.ARRAY_INDEX] = index_cap
	
	return surface_array_cap

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation.y += PI * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= PI * delta
	if Input.is_action_pressed("ui_up"):
		rotation.x += PI * delta
	if Input.is_action_pressed("ui_down"):
		rotation.x -= PI * delta
