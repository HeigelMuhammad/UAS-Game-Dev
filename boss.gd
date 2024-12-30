extends RigidBody2D
@onready var boss_dara = $AnimatedSprite2D

const SPEED = 100
var direction = 1

var enter_count = 0  # Variabel untuk menghitung jumlah 'body entered'

func _on_area_2d_body_entered(body):
	enter_count += 1  # Tambahkan hitungan setiap kali tubuh masuk
	if enter_count == 1:
		boss_dara.play("dead")
