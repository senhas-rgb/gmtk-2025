extends CharacterBody2D

@export var speed := 40
@export var patrol_distance := 100

var start_position: Vector2
var moving_right := true

func _ready():
	start_position = position

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
