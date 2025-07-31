extends CharacterBody2D

@export var speed := 200
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _physics_process(_delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()

	if direction.length() > 0:
		if not anim.is_playing() or anim.current_animation != "idle_front":
			anim.play("idle_front") # play other animation i didnt add the texture
		sprite.flip_h = direction.x < 0
	else:
		anim.play("idle_front")
		# Optionally reset to idle frame:
		# sprite.region_rect.position = Vector2(0, 0)
