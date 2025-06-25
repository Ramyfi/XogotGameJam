extends Node

class_name Stopwatch

var time = 0.0
var stopped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stopped:
		return
	time += delta
	
func reset():
	time = 0.0
	pass
