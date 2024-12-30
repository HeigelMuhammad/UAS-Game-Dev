extends Node
@onready var label = $Label
@onready var btn_stage_final = $"../Btn_stage_final"


var score = 0

func add_point_st3():
	score += 1
	label.text = "Sebanyak " + str(score) + " koin di stage 3."
	$"../AudioStreamPlayer2".play()
	
func show_btn():
	if score >= 25:
		btn_stage_final.show()

func _on_btn_stage_final_pressed():
	get_tree().change_scene_to_file("res://batle_4.tscn")
