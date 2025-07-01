extends Control

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		if _is_point_inside_button_area(event.position):
			pass
			
			
			
func _is_point_inside_button_area(point: Vector2) -> bool:
	var x: bool = point.x >= global_position.x and point.x <= global_position.x + (size.x * get_global_transform_with_canvas().get_scale().x)
	var y: bool = point.y >= global_position.y and point.y <= global_position.y + (size.y * get_global_transform_with_canvas().get_scale().y)
	return x and y
