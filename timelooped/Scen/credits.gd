extends VBoxContainer


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scen/menu.tscn")
