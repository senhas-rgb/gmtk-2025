extends Node2D

#Nuget Incorporated Battle System

@onready var info_label = $InfoLabel
@onready var attack_button = $Attack
@onready var heal_button = $Heal

var player_hp = call_health()
var enemy_hp = 10
var player_turn = true

func _ready():
	print("player health ", player_hp)
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
	$EnemyOuch.play()
	$EnemyHurtParticles.emitting = true
	info_label.text = "You attack! -3HP"
	await get_tree().create_timer(0.5).timeout
	$EnemyHurtParticles.emitting = false
	end_turn()

func _on_heal_pressed():
	if not player_turn:
		return
	player_hp += 4
	$PlayerHealParticles.emitting = true;
	info_label.text = "You healed! +4 HP!"
	await get_tree().create_timer(0.5).timeout
	$PlayerHealParticles.emitting = false;
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
	$PlayerHurtParticles.emitting = true;
	info_label.text = "Enemy hits you for 2!"
	await get_tree().create_timer(0.5).timeout
	$PlayerHurtParticles.emitting = false;
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
		var file = FileAccess.open("res://savegame.json",FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			
			var result = JSON.parse_string(content)
			if typeof(result) == TYPE_DICTIONARY and result.has("health"):
				return int(result["health"])
	return -1
