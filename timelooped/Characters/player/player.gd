extends CharacterBody2D
class_name Player

@onready var sprite = $Sprite2D
@onready var music_player = $"../AudioStreamPlayer"
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None # player doesnt have anything in start

const TILE_SIZE = 32
var last_grid_position: Vector2i

var health := 3
@export var speed := 100


var w_key := true
var a_key := true
var s_key := true
var d_key := true


func gridinator_inator() -> Vector2i:
	return Vector2i(floor(position.x / TILE_SIZE), floor(position.y / TILE_SIZE))
func _ready():
	last_grid_position = gridinator_inator()
	music_player.stream.loop = true
	var music = preload("res://Art/background.ogg") as AudioStreamOggVorbis
	music.loop = true
	music_player.stream = music
	music_player.play()
func _physics_process(delta):
	var current_grid = gridinator_inator()
	if current_grid != last_grid_position:
		print("nove grid", current_grid)
		last_grid_position = current_grid
	var direction = Vector2.ZERO

	if Input.is_action_pressed("right") and d_key:
		direction.x += 1
		sprite.play("run_side")
		sprite.flip_h = false
		w_key = false
		a_key = false
		s_key = false

	if Input.is_action_pressed("left") and a_key:
		direction.x -= 1
		sprite.play("run_side")
		sprite.flip_h = true
		w_key = false
		d_key = false
		s_key = false

	if Input.is_action_pressed("down") and s_key:
		direction.y += 1
		sprite.play("run_front")
		w_key = false
		a_key = false
		d_key = false

	if Input.is_action_pressed("up") and w_key:
		direction.y -= 1
		sprite.play("run_back")
		d_key = false
		a_key = false
		s_key = false

	if direction == Vector2.ZERO:
		w_key = true
		a_key = true
		s_key = true
		d_key = true

	velocity = direction * speed
	move_and_slide()

	# Idle animations
	if Input.is_action_just_released("down"):
		sprite.play("idle_front")
	if Input.is_action_just_released("up"):
		sprite.play("idle_back")
	if Input.is_action_just_released("left"):
		sprite.play("idle_side")
	if Input.is_action_just_released("right"):
		sprite.play("idle_side")
func hurt():
	health -= 1
	print("health", health)

	if health <= 0:
		skillissue()
	%HurtSound.play()
func skillissue():
	print("L bozo")
	queue_free()
	
func _process(delta: float) -> void:
	pass
