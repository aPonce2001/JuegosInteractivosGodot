extends Area2D


@export var speed = 750
signal died
@onready var enemy_stream_player = $EnemyStreamPlayer


func _physics_process(delta):
	self.position.x -= speed * delta


func die():
	emit_signal("died")
	enemy_stream_player.play()
	hide()
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, false)
	await enemy_stream_player.finished
	queue_free()


func _on_body_entered(body):
	die()
	body.take_damage()
