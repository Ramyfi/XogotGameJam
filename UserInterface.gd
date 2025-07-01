extends Control

var total_time := 120.0 # 2 minutes in seconds
var timer_finished := false


func _process(delta: float) -> void:
	if total_time > 0:
		total_time -= delta
		@warning_ignore("integer_division")
		var minutes = int(total_time) / 60
		var seconds = int(total_time) % 60
		$TimerLabel.text = "%d:%02d" % [minutes, seconds]
	else:
		$TimerLabel.text = "0:00"
		get_tree().change_scene_to_file("res://menu.tscn")
		
