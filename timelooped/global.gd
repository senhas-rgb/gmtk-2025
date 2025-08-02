extends Node

func _ready() -> void:
	var cursor_texture = load("res://art/ui/Sprite sheets/Mouse sprites/Triangle Mouse icon 1.png")
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, Vector2(0, 0))
