extends Control

@onready var play: Button = $VBoxContainer/play
@onready var credit: Button = $VBoxContainer/credit
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false

func _on_exit_button_pressed():
	get_tree().quit()



func _ready():
	audio_stream_player_2d.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")
	

func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/credits.tscn")


func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/settings.tscn")
	

	
