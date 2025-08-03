extends CharacterBody2D
class_name Player

@onready var sprite = $Sprite2D
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None # player doesnt have anything in start

const TILE_SIZE = 32
var last_grid_position: Vector2i
var rewind_point: Vector2 = Vector2.ZERO
var has_point = false

var health := 3

@export var base := 100
@export var fast := 300
@export var speed := 100


var w_key := true
var a_key := true
var s_key := true
var d_key := true


func gridinator_inator() -> Vector2i:
	return Vector2i(floor(position.x / TILE_SIZE), floor(position.y / TILE_SIZE))
func _ready():
	load_state_from_file()
	last_grid_position = gridinator_inator()
func _physics_process(delta):
	var current_grid = gridinator_inator()
	if current_grid != last_grid_position:
		print("nove grid", current_grid)
		last_grid_position = current_grid
	var direction = Vector2.ZERO
	
	handle_speeds(delta)

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
# handle the reverse and fast_forward
func handle_speeds(delta):
	if Input.is_action_just_pressed("make_rewind"):
		rewind_point = position
		has_point = true
		print("made rewind point at ", position)
	elif Input.is_action_just_pressed("rewind") and has_point:
		position = rewind_point
		print("rewound to ", rewind_point)
	elif Input.is_action_pressed("forward"):
		forward()

func forward():
	if Input.is_action_pressed("forward"):
		speed = fast
	else:
		speed = base
#dicktion
func get_game_state() -> Dictionary:
	return {
		"grid_position": gridinator_inator(), #not used
		"world_position": position, #not used
		"health": health,
		"current_tool": str(current_tool) 
	}
#nugets ultimate save engine, copyright Nuget Incorporated 2025 for the GMTK 2025 Game Jam, all rights reserved
func save_state_to_file():
	var state = get_game_state()
	var file = FileAccess.open("res://savegame.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(state))
		file.close()
		print("saved to ", file)
#nugets ultimate load engine, copyright Nuget Incorporated 2025 for the GMTK 2025 Game Jam, all rights reserved
func load_state_from_file():
	if FileAccess.file_exists("user://savegame.json"):
		var file = FileAccess.open("user://savegame.json", FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			
			var result = JSON.parse_string(content)
			if typeof(result) == TYPE_DICTIONARY:
				apply_game_state(result)
			else:
				print("json is fucked, all your savedata is gone")
		else:
			print("no save file found")
#apply actual stuff so it like actually works, copyright Nuget Incorporated 2025 for the GMTK 2025 Game Jam, all rights reserved
func apply_game_state(state: Dictionary):
		if state.has("health"):
			health = int(state["health"])
			print("Loaded health:", health)
