extends Area2D


@export var boost_velocity = -500.0
@onready var trampoline_sprite = $AnimatedSprite2D


func _on_body_entered(body):
	trampoline_sprite.play("activation")
	body.velocity.y = boost_velocity
	body.move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	trampoline_sprite.play("idle")
