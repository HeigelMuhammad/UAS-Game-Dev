extends Area2D
@onready var game_manager_stage_2 = %"Game Manager Stage 2"


func _on_body_entered(body):
	game_manager_stage_2.add_point_st2()
	queue_free()
