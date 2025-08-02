extends Node2D
@onready var area = $apple
var balloon_scene = preload("res://dialog/game_dialuge_balloon.tscn")


func _ready():
	area.body_entered.connect(_on_player_near)
	area.body_exited.connect(_on_player_far)

func _on_player_near(body):
	if body.name == "Player":
		print("Player is near the apple")
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialog/story/player_see_apple.dialogue"), "start")
		area.visible = false;

func _on_player_far(body):
	if body.name == "Player":
		print("Player walked away from the apple")
