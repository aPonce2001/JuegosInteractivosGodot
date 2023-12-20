extends CharacterBody2D


@export var speed = 400


@export var clamp_padding_x = 30


@export var clamp_padding_y = 30


func _process_input_for_movement():
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


func _physics_process(delta):
	var direction = _process_input_for_movement()
	velocity = speed * direction
	move_and_slide()
	clamp_global_position()

func clamp_global_position():
	global_position = global_position.clamp(
		Vector2(clamp_padding_x, clamp_padding_y),
		get_viewport_rect().size - Vector2(clamp_padding_x, clamp_padding_y)
	)

'''
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
'''
