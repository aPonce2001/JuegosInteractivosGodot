extends Node


const sfx_dict = {
	"hurt": preload("res://assets/sfx/hurt.wav"),
	"jump": preload("res://assets/sfx/jump.wav")
}


func play_sfx(sfx_name: String):
	if sfx_dict.has(sfx_name):
		var asp = AudioStreamPlayer2D.new()
		asp.name = sfx_name
		asp.stream = sfx_dict[sfx_name]
		add_child(asp)
		asp.play()
		await asp.finished
		asp.queue_free()
