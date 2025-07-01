extends Control

@onready var transition_delay := 1.0  # seconds

func _ready() -> void:
	var knife_cursor = load("res://assets/art/butcherKnife.png")
	Input.set_custom_mouse_cursor(knife_cursor, Input.CURSOR_ARROW, Vector2(0, 0))
	#var vbox = $TextureRect/options_menu
	#vbox.visible = not vbox.visible
	

func _on_play_pressed() -> void:
	#self.position.y += -2  # Move button down slightly
	#self.scale = Vector2(0.95, 0.95)
	await get_tree().create_timer(transition_delay).timeout
	get_tree().change_scene_to_file("res://Main.tscn")
	var vbox = $main
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
	

func _on_settings_pressed() -> void:
	var vbox = $TextureRect/main_menu
	vbox.visible = not vbox.visible
	var vbox1 = $TextureRect/options_menu
	vbox1.visible = not vbox.visible


func _on_back_pressed() -> void:
	var vbox = $TextureRect/main_menu
	vbox.visible = not vbox.visible
	var vbox1 = $TextureRect/options_menu
	vbox1.visible = not vbox.visible
