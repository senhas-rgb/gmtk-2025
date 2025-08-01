extends Control

@onready var play: Button = $VBoxContainer/play
@onready var credit: Button = $VBoxContainer/credit
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	audio_stream_player_2d.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")
	

func _on_credit_pressed() -> void:
	pass # Replace with function body.


func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/settings.tscn")
