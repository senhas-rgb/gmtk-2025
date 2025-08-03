extends Node2D

var balloon_scene = preload("res://dialog/game_dialuge_balloon.tscn")

@onready var interactable_component: Interactable = $Interactable
@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var enemy: CharacterBody2D = $"."
@onready var collision: CollisionShape2D = $Interactable/CollisionShape2D
@onready var collision2: CollisionShape2D = $HurtZone/CollisionShape2D
@onready var in_range: bool
@onready var killed: bool = false;

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	if killed == true:
		queue_free()
		collision.disabled = true
		collision2.disabled = true
	
func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true
		
func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false
	killed = true
	queue_free()
	collision.disabled = true
	collision2.disabled = true

func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("show_dialogue"):
			var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
			get_tree().current_scene.add_child(balloon)
			balloon.start(load("res://dialog/misc/enemy.dialogue"), "start")
