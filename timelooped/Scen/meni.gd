extends Control

@onready var play: Button = $VBoxContainer/play
@onready var credit: Button = $VBoxContainer/credit
@onready var splash_text: RichTextLabel = $"Splash Text"

var os_name = OS.get_name()
var splash = {}

func _ready():
	randomize()
	print(os_name)
	load_splash_data()
	random_splash()

func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false

func _on_exit_button_pressed():
	get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/tutorial.tscn")

func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scen/credits.tscn")

# splash
func load_splash_data():
	var file = FileAccess.open("res://Other/splash.json", FileAccess.READ)
	if file:
		splash = JSON.parse_string(file.get_as_text())
		file.close()

func random_splash():
	var key = os_name if splash.has(os_name) else "Other"
	var messages = splash[key]
	if messages.size() > 0:
		splash_text.text = messages[randi() % messages.size()]
