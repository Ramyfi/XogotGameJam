extends Node3D
var lineSpawner = LineSpawn.new()

var veggieObjects = [load("res://pepper.tscn"),load("res://onion.tscn"), load("res://tomato.tscn")]
var bimpleResource = load("res://bimple.tscn")
var rotateScript = preload("res://CubeRotation.gd")
var rng = RandomNumberGenerator.new()

var currentVeggie = null

func _ready() -> void:
	add_child(lineSpawner)
	set_new_veggie()

func _doIt() -> void:
	veggie_yeet()
	set_new_veggie()
	# set up random line, restart timer

# a box should despawn the veggies
func veggie_yeet() -> void:
	var body = get_node("veggie/RigidBody3D")
	body.set_script(null)
	
	# yeet
	body.apply_central_impulse(Vector3(-100, 0, 0))
	get_node("veggie/RigidBody3D2").apply_central_impulse(Vector3(-100, 0, 0))

func set_new_veggie() -> void:
	currentVeggie = veggieObjects.get(rng.randi_range(0, 2)).instantiate()
	currentVeggie.set_script(rotateScript)
	add_child(currentVeggie, true) #idk that's not how this works I want it to be a set name or something . or live in a specific function .idk
	var bimple = bimpleResource.instantiate()
	lineSpawner.spawn_line(currentVeggie.get_node("RigidBody3D/MeshInstance3D").mesh, bimple, currentVeggie as Node)
	currentVeggie.add_child(bimple)
