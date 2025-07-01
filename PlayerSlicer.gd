extends Node3D

var meshSlicer = MeshSlicer.new()


@onready var slicer = $Slicer/SlicePlane

func _ready() -> void:
	add_child(meshSlicer)
	

func _process(_delta):	
	if Input.is_action_just_pressed("Slice"):
		$Slicer/Knife/AnimationPlayer.play("chop")
	
		for body in $Slicer/Area3D.get_overlapping_bodies().duplicate():
			if body is RigidBody3D:
				var meshInstance = body.get_node("MeshInstance3D")
				
				var transform = calculate_transform(meshInstance, body)
				
				var slices = meshSlicer.slice_mesh(transform, meshInstance.mesh)
				set_slice_to_mesh(body, slices[0])
				
				# TODO: eh it should not be rotating all of these forever. stop that.
				var body2 = body.duplicate()
				body.add_child(body2)
				set_slice_to_mesh(body2, slices[1])
				
				if body2 is RigidBody3D:
					body2.set_gravity_scale(1.0)
					

func calculate_transform(meshInstance: MeshInstance3D, body: RigidBody3D) -> Transform3D:
	var transform = Transform3D.IDENTITY
	transform.origin = meshInstance.to_local((slicer.global_transform.origin))
	transform.basis.x = meshInstance.to_local((slicer.global_transform.basis.x + body.global_position))
	transform.basis.y = meshInstance.to_local((slicer.global_transform.basis.y + body.global_position))
	transform.basis.z = meshInstance.to_local((slicer.global_transform.basis.z + body.global_position))
	return transform

func calculate_mesh_volume(mesh: ArrayMesh) -> float:
	var volume = 0.0
	for surface in range(mesh.get_surface_count()):
		var arrays = mesh.surface_get_arrays(surface)
		var vertices = arrays[Mesh.ARRAY_VERTEX]
		for i in range(0, vertices.size(), 3):
			var v1 = vertices[i]
			var v2 = vertices[i + 1]
			var v3 = vertices[i + 2]
			volume += abs(v1.dot(v2.cross(v3))) / 6.0
	return volume

func calculate_center_of_mass(mesh: ArrayMesh) -> Vector3:
	#Not sure how well this work
	var meshVolume = 0
	var temp = Vector3(0,0,0)
	for i in range(len(mesh.get_faces())/3):
		var v1 = mesh.get_faces()[i]
		var v2 = mesh.get_faces()[i+1]
		var v3 = mesh.get_faces()[i+2]
		var center = (v1 + v2 + v3) / 3
		var volume = (Geometry3D.get_closest_point_to_segment_uncapped(v3,v1,v2).distance_to(v3)*v1.distance_to(v2))/2
		meshVolume += volume
		temp += center * volume
	
	if meshVolume == 0:
		return Vector3.ZERO
	return temp / meshVolume
	
func set_slice_to_mesh(body: RigidBody3D, mesh: ArrayMesh) -> void:
	body.get_node("MeshInstance3D").mesh = mesh
	if len(mesh.get_faces()) > 2:
		body.get_node("CollisionShape3D").shape = mesh.create_convex_shape()
