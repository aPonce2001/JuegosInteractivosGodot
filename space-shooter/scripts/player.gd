extends CharacterBody2D


@export var speed = 400
@export var bullet_speed = 2000
@export var clamp_padding_x = 30
@export var clamp_padding_y = 30
@export var slow_move_factor = 0.5
@onready var rocket_scene = preload("res://scenes/bullet.tscn")
signal took_damage
@onready var shoot_stream_player = $ShootStreamPlayer
@onready var hurt_stream_player = $HurtStreamPlayer
@onready var dead_stream_player = $DeadStreamPlayer


func process_input_for_movement():
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	return direction.normalized()

func process_input_for_actions():
	if Input.is_action_just_pressed("shoot"):
		shoot()
		$shoot_timer.start()
	if Input.is_action_just_released("shoot"):
		$shoot_timer.stop()
	
	if Input.is_action_just_pressed("slow_move"):
		speed = slow_move_factor * speed
	if Input.is_action_just_released("slow_move"):
		speed = (1/slow_move_factor) * speed 
	


func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocket_instance.speed = bullet_speed
	rocket_instance.position = global_position
	get_parent().add_child(rocket_instance)
	shoot_stream_player.play()


func _process(delta):
	process_input_for_actions()


func _physics_process(delta):
	var direction = process_input_for_movement()
	velocity = speed * direction
	move_and_slide()
	clamp_global_position()


func clamp_global_position():
	global_position = global_position.clamp(
		Vector2(clamp_padding_x, clamp_padding_y),
		get_viewport_rect().size - Vector2(clamp_padding_x, clamp_padding_y)
	)


func _on_shoot_timer_timeout():
	shoot()


func take_damage():
	hurt_stream_player.play()
	emit_signal("took_damage")


func die():
	dead_stream_player.play()
	hide()
	set_collision_layer_value(1, false)
	await dead_stream_player.finished
	queue_free()
