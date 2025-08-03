extends Control

@onready var play: Button = $VBoxContainer/play
@onready var credit: Button = $VBoxContainer/credit





func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false

func _on_exit_button_pressed():
	get_tree().quit()



func _ready():
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/tutorial.tscn")
	

func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/credits.tscn")
