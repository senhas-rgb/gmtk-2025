extends Node2D

func _ready() -> void:
	if Global.enemy_defeated == true:
		$Enemy.hide()
