extends Node2D


@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var spawn_positions = $"spawn-positions"
signal enemy_spawned

func _on_timer_timeout():
	spawn()


func spawn():
	var spawn_positions_array = spawn_positions.get_children()
	var spawn_position_item = spawn_positions_array.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = spawn_position_item.position
	add_child(enemy_instance)
	emit_signal("enemy_spawned", enemy_instance)
