extends Node

func _ready() -> void:
	var cursor_texture = load("res://art/ui/Sprite sheets/Mouse sprites/Triangle Mouse icon 1.png")
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, Vector2(0, 0))

signal change_change_signal



func action_change_scene(path) -> void:
	get_tree().change_scene_to_file(path)
