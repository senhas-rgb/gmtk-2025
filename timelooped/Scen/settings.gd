extends Control



func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
