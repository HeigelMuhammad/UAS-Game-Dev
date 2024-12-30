extends Node
@onready var score_label = $"Score Label"

var score_st2 = 0

func add_point_st2():
	score_st2 += 1
	score_label.text = "Sebanyak " + str(score_st2) + " koin di stage 3."
	$"../AudioStreamPlayer2".play()
