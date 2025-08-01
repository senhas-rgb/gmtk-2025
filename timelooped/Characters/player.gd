extends CharacterBody2D

@export var speed := 200
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var music_player = $"../AudioStreamPlayer"

var w_key := true;
var a_key := true;
var s_key := true;
var d_key := true;

func _ready():
	music_player.stream.loop = true
	var music = preload("res://Art/background.ogg") as AudioStreamOggVorbis
	music.loop = true
	music_player.stream = music
	music_player.play()

	


func _physics_process(_delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("right") and d_key:
		direction.x += 1
		anim.play("run_side")
		sprite.flip_h = direction.x < 0
		w_key = false;
		a_key = false;
		s_key = false;
	if Input.is_action_pressed("left") and a_key:
		direction.x -= 1
		sprite.flip_h = direction.x < 0
		anim.play("run_side")
		w_key = false;
		d_key = false;
		s_key = false;
	if Input.is_action_pressed("down") and s_key:
		direction.y += 1
		anim.play("run_front")
		w_key = false;
		a_key = false;
		d_key = false;
	if Input.is_action_pressed("up") and w_key:
		direction.y -= 1
		anim.play("run_back")
		d_key = false;
		a_key = false;
		s_key = false;
	else :
		w_key = true;
		a_key = true;
		s_key = true;
		d_key = true;

	velocity = direction.normalized() * speed
	move_and_slide()
	
	if Input.is_action_just_released("down"):
		anim.play("idle_front")
	if Input.is_action_just_released("up"):
		anim.play("idle_back")
	if Input.is_action_just_released("left"):
		anim.play("idle_front")
	if Input.is_action_just_released("right"):
		anim.play("idle_front")
