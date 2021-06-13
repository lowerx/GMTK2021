extends KinematicBody2D

var rotation_speed
var area
var hp: float = 100.0
var rotation_dir = -1


func get_margins(_size: Vector2):
	area = _size.x * _size.y
	rotation_speed = 10000 / area


func hp_check():
	if hp <= 0:
		queue_free()
