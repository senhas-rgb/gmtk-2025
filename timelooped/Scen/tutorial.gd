extends ColorRect

@onready var button: Button = $Button
@onready var music: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	music.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/intro.tscn")
