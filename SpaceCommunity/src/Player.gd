extends KinematicBody2D

const move_speed = 14000
const bullet_speed = 1000
const fire_rate = 0.5
var fire_time = 0.0


var bullet = preload("res://src/Actors/Bullet.tscn")


func _physics_process(delta: float) -> void:
	var direction: = Vector2()
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	direction = direction.normalized()
	move_and_slide(direction * move_speed * delta)
	look_at(get_global_mouse_position())
	
	
	if Input.is_action_just_pressed("shoot"):
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
	
