extends Node

class_name LineSpawn

var rng = RandomNumberGenerator.new()

func spawn_line(mesh : ArrayMesh, bimple : MeshInstance3D, nd : Node) -> void:
	var mdt = MeshDataTool.new() 
	
	#get surface 0 into mesh data tool
	mdt.create_from_surface(mesh, 0)
	
	var index = rng.randi_range(0, mdt.get_vertex_count())
	var vert = mdt.get_vertex(index)
	#bimple.to_local(nd.global_transform.xform(vert))
	bimple.global_position = bimple.global_transform * vert
	
	#for vtx in range(mdt.get_vertex_count()):
		#var vert=mdt.get_vertex(vtx)
		#print("global vertex: "+str(nd.global_transform.xform(vert)))
