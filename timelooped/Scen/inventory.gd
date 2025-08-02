extends CanvasLayer

@onready var select_pointer = $Control/NinePatchRect/TextureRect
@onready var menu = $Control
@onready var player = $"../Player"

enum ScreenLoaded { NOTHING, JUST_MENU}
var screen_loaded = ScreenLoaded.NOTHING

var selected_option: int = 0

func _ready() -> void:
	menu.visible = false;
	select_pointer.position.y = 75.74 + (selected_option % 3) * 55
	select_pointer.position.x = 4.26
	
func _unhandled_input(event) -> void:
	match screen_loaded:
		ScreenLoaded.NOTHING:
			if event.is_action_pressed("menu_key"):
				menu.visible = true
				screen_loaded = ScreenLoaded.JUST_MENU
		ScreenLoaded.JUST_MENU:
			if event.is_action_pressed("menu_key") or event.is_action_pressed("select"):
				menu.visible = false
				screen_loaded = ScreenLoaded.NOTHING
			elif event.is_action_pressed("ui_down"):
				selected_option += 1
				select_pointer.position.y = 75.74 + (selected_option % 3) * 55

			elif event.is_action_pressed("ui_up"):
				if selected_option == 0:
					selected_option = 5
				else:
					selected_option -= 1
				select_pointer.position.y = 75.74 + (selected_option % 3) * 55
