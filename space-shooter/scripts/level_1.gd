extends Node2D


var enemy_scene

func _ready():
	enemy_scene = preload("res://scenes/enemy.tscn")


func _on_enemytimer_timeout():
	var enemy_instance = enemy_scene.instantiate()
	var random_y = randf_range(0, get_viewport_rect().size.y)
	enemy_instance.position = Vector2(1226, random_y)
	add_child(enemy_instance)
