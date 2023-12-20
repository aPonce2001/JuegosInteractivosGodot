extends Area2D


@export var speed = 750


func _physics_process(delta):
	self.position.x -= speed * delta
