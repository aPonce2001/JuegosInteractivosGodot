extends Control


@onready var score_label = $Panel/ScoreLabel


func _on_retry_button_pressed():
	get_tree().reload_current_scene()


func set_score(score):
	score_label.text = "Score: %s" % str(score)
