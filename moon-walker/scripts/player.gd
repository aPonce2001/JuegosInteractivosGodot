extends CharacterBody2D


@export var speed = 200.0
@export var jump_velocity = -400.0
var active = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const lines: Array[String] = [
	"Hello, this is my adventure!",
	"Second line",
	"Third line"
]

@onready var player_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 700.0:
			velocity.y = 700.0
	
	var direction = 0
	if active:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()
			
		if Input.is_action_just_pressed("dialog"):
			DialogManager.start_dialog(global_position, lines)
		
		direction = Input.get_axis("move_left", "move_right")
		velocity.x = direction * speed
		if direction != 0:
			player_sprite.flip_h = direction == -1
	move_and_slide()
	update_animations(direction)

func jump():
	AudioPlayer.play_sfx("jump")
	velocity.y += jump_velocity

func update_animations(direction):
	if not is_on_floor():
		if velocity.y < 0:
			player_sprite.play("jumping")
		else:
			player_sprite.play("falling")
		return
	
	if direction != 0:
		player_sprite.play("run")
	else:
		player_sprite.play("idle")

func set_active(value):
	active = value
