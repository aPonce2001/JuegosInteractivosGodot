extends CanvasLayer


@onready var left_time_label = $Control/LeftTimeLabel
@onready var win_screen = $WinScreen


func set_left_time_label(left_time):
	left_time_label.text = str(left_time)

func show_win_screen():
	win_screen.visible = true
