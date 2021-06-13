extends KinematicBody2D

export (int) var speed = 800


const bullet_speed = 5000
const fire_rate = 0.5
var fire_time = 0.0

var bullet = preload("res://src/Actors/Bullet.tscn")

var velocity = Vector2()


func get_input():
	_look_at_mouse()
	velocity = Vector2()
	if Input.is_action_pressed("fly"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("shoot"):
		shoot()


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _look_at_mouse():
	look_at(get_global_mouse_position())
	$PlayerModel.rotation_degrees = 90


func shoot():
	if get_time() - fire_time < fire_rate:
		return
	fire_time = get_time()
	var bul = bullet.instance()
	bul.rotation_degrees = rotation_degrees + 90
	bul.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bul)
	bul.global_position = $FirePoint.global_position


func get_time():
	return OS.get_ticks_msec() / 1000
