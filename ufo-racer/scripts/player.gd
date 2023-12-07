extends RigidBody2D


func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		apply_force(Vector2(0, -1000))
	
	if Input.is_action_pressed("move_down"):
		apply_force(Vector2(0, 1000))
	
	if Input.is_action_pressed("move_left"):
		apply_force(Vector2(-1000, 0))
	
	if Input.is_action_pressed("move_right"):
		apply_force(Vector2(1000, 0))
