extends Area2D

@onready var game_manager_stage_3 = %"Game Manager"


func _on_body_entered(body):
	if body.name == "Player":  # Pastikan hanya pemain yang memicu
		game_manager_stage_3.add_point_st3()
		queue_free()  # Hapus koin
