extends CharacterBody2D

@export var speed := 200
@export var dash_speed := 600

@onready var sprite = $Sprite2D
@onready var music_player = $"../AudioStreamPlayer"
@onready var sfx = $"../sfx"

@onready var stamina_bar = $"../UI/Stamina"
var stamina := 100.0
var max_stamina := 100.0

var w_key := true
var a_key := true
var s_key := true
var d_key := true

# Dash
var is_dashing = false
var dash_time := 0.2
var dash_cooldown := 1.5
var dash_timer := 0.0
var can_dash := true
var dash_direction := Vector2.ZERO

func start_dash_cooldown() -> void:
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true


func _ready():
	music_player.stream.loop = true
	var music = preload("res://Art/background.ogg") as AudioStreamOggVorbis
	music.loop = true
	music_player.stream = music
	music_player.play()

func _physics_process(delta):
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

	# Dash input
	if Input.is_action_just_pressed("dash") and can_dash and stamina >= 20:
		is_dashing = true
		can_dash = false
		dash_timer = dash_time
		dash_direction = direction.normalized() if direction != Vector2.ZERO else velocity.normalized()
		var whoosh = preload("res://Art/whooshshort.mp3")
		sfx.stream = whoosh
		sfx.play()
		stamina -= 20
		stamina_bar.value = stamina

	# Dash logic
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			start_dash_cooldown()
	else:
		velocity = direction.normalized() * speed

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
		


	if Input.is_action_just_released("down") or Input.is_action_just_released("up") or Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		if stamina < 100:
			stamina += 5 * delta
			stamina = clamp(stamina, 0, 100)
			stamina_bar.value = stamina
