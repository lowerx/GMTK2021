extends Node2D

const width = 1910
const height = 1060
const ASTEROID = preload("res://src/Actors/Asteroid.tscn")

var spawn_area = Rect2()

var delta = 2
var offset = 0.5

func _ready() -> void:
	randomize()
	spawn_area = Rect2(0,0,width, height)
	set_next_spawn()

func spawn_asteroid():
	var position = Vector2(randi()%width, randi()%height)
	
	var asteroid = ASTEROID.instance()
	asteroid.position = position
	add_child(asteroid)
	
	return position


func set_next_spawn():
	var next_time = delta + (randf()-0.5)*2*offset
	$Timer.wait_time = next_time
	$Timer.start()

func _on_timeout() -> void:
	spawn_asteroid()
	set_next_spawn()

#func _draw() -> void:
#	var radius = 20
#	draw_rect(spawn_area, Color(0.2,0.2,1.0,0.5))
#
#	for i in range(25):
#		draw_circle(spawn_enemy(),radius, Color.red)
