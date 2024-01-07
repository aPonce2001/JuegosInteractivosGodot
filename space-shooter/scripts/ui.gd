extends Control


@onready var score_label = $ScoreLabel
@onready var lives_label = $LivesLabel


func set_score(score):	
	score_label.text = "Score: %s" % str(score)


func set_lives(lives):
	var lives_str
	if (int(lives) >= 0):
		lives_str = str(lives)
	else:
		lives_str = "0"
	lives_label.text = "%s" % lives_str
