extends RigidBody2D

@onready var orc_shaman = $AnimatedSprite2D
const SPEED = 100
var direction = 1

var hp = 1
var enter_count = 0  # Variabel untuk menghitung jumlah 'body entered'
@onready var ray_cast_kanan = $RayCastKanan
@onready var ray_cast_kiri = $RayCastKiri



func _process(delta):
	if enter_count >= 1:
		return  # Menghentikan eksekusi fungsi jika enter_count >= 3
	
	if ray_cast_kanan.is_colliding():
		direction = -1
		orc_shaman.flip_h = true
	if ray_cast_kiri.is_colliding():
		direction = 1
		orc_shaman.flip_h = false
	
	position.x += direction * SPEED * delta

# Dipanggil saat tubuh memasuki Area2D
func _on_area_2d_body_entered(body):
	enter_count += 1  # Tambahkan hitungan setiap kali tubuh masuk
	if enter_count == 1:
		orc_shaman.play("dead")  # Mainkan animasi 'dead'

