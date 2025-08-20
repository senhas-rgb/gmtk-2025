extends Control

@onready var play: Button = $play
@onready var credit: Button = $credit
@onready var buttons_parent: Control = $"."
@onready var splash_text: RichTextLabel = $"Splash Text"
@onready var red_bg: AnimatedSprite2D = $AngledRed
@onready var green_bg: AnimatedSprite2D = $AngledGreen


var os_name = OS.get_name()
var splash = {}
var themes = {
	"play": preload("res://Art/Menu/red.tres"),
	"credit": preload("res://Art/Menu/green.tres")
}

func _ready():
	randomize()
	print(os_name)
	load_splash_data()
	random_splash()
	
	play.connect("mouse_entered", Callable(self, "_on_button_hovered").bind("play"))
	credit.connect("mouse_entered", Callable(self, "_on_button_hovered").bind("credit"))


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


func _on_button_hovered(theme_name: String):
	if not themes.has(theme_name):
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	
	match theme_name:
		"play":
			tween.tween_property(red_bg, "modulate:a", 1.0, 0.2)
			tween.tween_property(green_bg, "modulate:a", 0.0, 0.2)
		"credit":
			tween.tween_property(red_bg, "modulate:a", 0.0, 0.2)
			tween.tween_property(green_bg, "modulate:a", 1.0, 0.2)

	var new_theme = themes[theme_name]
	for button in buttons_parent.get_children():
		if button is Button:
			button.theme = new_theme
