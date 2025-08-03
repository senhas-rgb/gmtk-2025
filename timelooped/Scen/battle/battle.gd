extends Node2D

#Nuget Incorporated Battle System

@onready var info_label = $InfoLabel
@onready var attack_button = $Attack
@onready var heal_button = $Heal

var player_hp = 10
var enemy_hp = 10
var player_turn = true

func _ready():
	$Enemy.flip_h = true
	update_ui()
	attack_button.pressed.connect(_on_attack_pressed)
	heal_button.pressed.connect(_on_heal_pressed)

func _physics_process(delta: float) -> void:
	$Player.play("idle_side")
	$Enemy.play("idle")
	
func _on_attack_pressed():
	if not player_turn:
		return
	enemy_hp -= 3
	info_label.text = "You attack! -3HP"
	end_turn()

func _on_heal_pressed():
	if not player_turn:
		return
	player_hp += 4
	info_label.text = "You healed! +4 HP!"
	end_turn()

func end_turn():
	player_turn = false
	update_ui()
	await get_tree().create_timer(1.0).timeout
	enemy_action()

func enemy_action():
	if enemy_hp <= 0:
		info_label.text = "You win!"
		$Enemy.hide()
		attack_button.hide()
		heal_button.hide()
		Global.enemy_defeated = true
		get_tree().change_scene_to_file("res://Levels/house.tscn")
	

	player_hp -= 2
	$Ouch.play()
	info_label.text = "Enemy hits you for 2!"
	player_turn = true

	if player_hp <= 0:
		get_tree().change_scene_to_file("res://Scen/menu.tscn")
	else:
		update_ui()

func update_ui():
	attack_button.disabled = not player_turn
	heal_button.disabled = not player_turn
	info_label.text += "\nYour HP: %d  |  Enemy HP: %d" % [player_hp, enemy_hp]

func call_health():
	if FileAccess.file_exists("res://savegame.json"):
		pass
