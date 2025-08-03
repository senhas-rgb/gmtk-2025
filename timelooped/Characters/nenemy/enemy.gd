extends CharacterBody2D

@export var speed := 40
@export var patrol_distance := 100
@onready var getkilledzone = $KillEnemyZone
var balloon_scene = preload("res://dialog/game_dialuge_balloon.tscn")

var start_position: Vector2
var moving_right := true

func _ready():
	start_position = position
	getkilledzone.body_entered.connect(_on_player_near)
	getkilledzone.body_exited.connect(_on_player_far)
	

func _physics_process(delta):
	var direction = Vector2.RIGHT if moving_right else Vector2.LEFT
	velocity = direction * speed
	move_and_slide()

	if abs(position.x - start_position.x) > patrol_distance:
		moving_right = !moving_right



func _on_hurt_zone_body_entered(body: Node2D) -> void:
	print("touch poke prod whiaodsadh9iosaumdhioasda")

	if body is Player:
		body.hurt()



func _on_player_near(body) -> void:
	if body.name == "Player":
		print("Player is near the apple")
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialog/story/player_see_apple.dialogue"), "start")

func _on_player_far(body):
	if body.name == "Player":
		print("Player walked away from the apple")
