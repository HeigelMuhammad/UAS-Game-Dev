extends RigidBody2D

@onready var dara = $AnimatedSprite2D

const BASE_SPEED = 170  # Kecepatan dasar
var SPEED = BASE_SPEED  # Kecepatan yang dapat diubah
var direction = 1

var hp = 1
var enter_count = 0  # Variabel untuk menghitung jumlah 'body entered'
@onready var ray_cast_kanan = $RayCastKanan
@onready var ray_cast_kiri = $RayCastKiri
@onready var quit = $"../QUIT"


func _process(delta):
	if enter_count >= 20:
		return  # Menghentikan eksekusi fungsi jika enter_count >= 20
	
	# Tambahkan logika untuk meningkatkan SPEED
	if enter_count > 10:
		SPEED = BASE_SPEED + 80  # Tambahkan 50 ke kecepatan dasar
	else:
		SPEED = BASE_SPEED  # Kembali ke kecepatan dasar
	
	if ray_cast_kanan.is_colliding():
		direction = -1
		dara.flip_h = true
	if ray_cast_kiri.is_colliding():
		direction = 1
		dara.flip_h = false
	
	position.x += direction * SPEED * delta

# Dipanggil saat tubuh memasuki Area2D
func _on_area_2d_body_entered(body):
	enter_count += 1  # Tambahkan hitungan setiap kali tubuh masuk
	
	if enter_count < 25:
		dara.play("hurt")  # Mainkan animasi 'hurt'
		await get_tree().create_timer(0.5).timeout  # Tunggu 0.5 detik sebelum kembali ke animasi default
		dara.play("default")  # Kembali ke animasi 'default'
	elif enter_count == 25:
		dara.play("dead")  # Mainkan animasi 'dead'
		quit.show()
