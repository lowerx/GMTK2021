extends KinematicBody2D

const move_speed = 14000
const bullet_speed = 1000
const fire_rate = 0.5
var fire_time = 0.0


var bullet = preload("res://src/Actors/Bullet.tscn")


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	$PlayerModel.rotation_degrees = 90
	var direction: = Vector2()
	var mousepoint = get_global_mouse_position()
	var self_position = $PlayerModel.get_position()
	if Input.is_action_pressed("fly"):
		direction = (mousepoint - self_position).normalized()
		move_and_slide(direction * move_speed * delta)
	if Input.is_action_pressed("shoot"):
		shoot()


func shoot():
	if get_time() - fire_time < fire_rate:
		return
	fire_time = get_time()
	var bul = bullet.instance()
	bul.rotation_degrees = rotation_degrees
	bul.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().add_child(bul)
	bul.global_position = $FirePoint.global_position


func get_time():
	return OS.get_ticks_msec() / 1000
