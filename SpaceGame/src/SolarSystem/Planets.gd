extends KinematicBody2D

var rotation_speed
var area
var hp: float = 100.0
var rotation_dir = -1
var lost_planets = 0


func get_margins(_size: Vector2):
	area = _size.x * _size.y
	rotation_speed = 10000 / area


func hp_check():
	if hp <= 0:
<<<<<<< HEAD
		AutoLoad.planets.erase(self)
=======
		lost_planets += 1 
>>>>>>> e36cbf36b524812d0f9d32c57f805bcaedef6e5d
		queue_free()
	if lost_planets == 4:
		get_tree().change_scene("res://src/Screens/FailScreen.tscn")
	

