extends CharacterBody2D
@export var tweentime = 1

var playerdetected = false;


func _process(delta: float) -> void:
	
	var tween = get_tree().create_tween()
	if (!playerdetected):
		tween.stop()
	tween.tween_property($".", "position", Vector2(%Player.position.x, %Player.position.y), tweentime)


func _on_detection_area_area_entered(area: Area2D) -> void:
	if (area.name != "EnemyArea"):
		playerdetected = true;

func _on_detection_area_area_exited(area: Area2D) -> void:
	if (area.name != "EnemyArea"):
		playerdetected = false;
