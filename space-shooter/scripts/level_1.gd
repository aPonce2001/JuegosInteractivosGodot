extends Node2D


@onready var player_node = $player
@onready var hud = $HUD
@onready var ui = $HUD/UI
@onready var game_over_scene = preload("res://scenes/game_over.tscn")
var score = 0
var lives = 3


func _on_player_took_damage():
	lives -= 1
	ui.set_lives(lives)
	score -= 1000
	ui.set_score(score)
	if lives < 0:
		player_node.die()
		var game_over_instance = game_over_scene.instantiate()
		hud.add_child(game_over_instance)
		game_over_instance.set_score(score)


func _on_enemyspawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)


func _on_enemy_died():
	score += 1000
	ui.set_score(score)
