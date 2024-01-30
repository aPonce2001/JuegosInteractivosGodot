extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level = false
@onready var player = $Player
@onready var start_point = $StartPoint
@onready var exit_area = $ExitArea
var timer_node = null
var time_left
@export var level_time = 5
@onready var ui = $UI


func _ready():
	# Timer
	timer_node = Timer.new()
	timer_node.name = 'Level Timer'
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timeout)
	add_child(timer_node)
	time_left = level_time
	ui.set_left_time_label(time_left)
	timer_node.start()
	
	exit_area.body_entered.connect(_on_exit_body_entered)
	var traps = get_tree().get_nodes_in_group("Traps")
	for trap in traps:
		trap.connect("player_hit", _on_trap_player_hit)
	player.global_position = start_point.global_position


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
			get_tree().quit()
	if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()


func _on_death_zone_body_entered(_body):
	_reset_player()


func _reset_player():
	player.global_position = start_point.global_position


func _on_trap_player_hit():
	AudioPlayer.play_sfx("hurt")
	_reset_player()


func _on_exit_body_entered(body):
	exit_area.animate()
	timer_node.stop()
	player.set_active(false)
	
	if next_level != null:
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)
	elif is_final_level:
		ui.show_win_screen()

func _on_level_timeout():
	time_left -= 1
	if (time_left < 0):
		_reset_player()
		time_left = level_time
		ui.set_left_time_label(time_left)
	else :
		ui.set_left_time_label(time_left)
