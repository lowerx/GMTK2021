extends Node2D

const width = 1910
const height = 1060
const ASTEROID = preload("res://src/Objects/Asteroid.tscn")

#var spawn_area = Rect2()

#var delta = 2
#var offset = 0.5

func _ready() -> void:
	randomize()
#	spawn_area = Rect2(0,0,width, height)
#	set_next_spawn()
	get_tree().call_group("asteroids", "queue_free")
	$Timer.start()


func _on_Timer_timeout():
	var asteroid_spawn_location = $Path2D/PathFollow2D
	asteroid_spawn_location.unit_offset = randf()
	
	var asteroid = ASTEROID.instance()
	add_child(asteroid)
	
	asteroid.position = asteroid_spawn_location.position
	
	var direction = asteroid_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	
	var velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = velocity.rotated(direction)

#func spawn_asteroid():
#	var position = Vector2(randi()%width, randi()%height)
#	
#	var asteroid = ASTEROID.instance()
#	asteroid.position = position
#	add_child(asteroid)
#	
#	return position


#func set_next_spawn():
#	var next_time = delta + (randf()-0.5)*2*offset
#	$Timer.wait_time = next_time
#	$Timer.start()

#func _on_timeout() -> void:
#	spawn_asteroid()
#	set_next_spawn()

#func _draw() -> void:
#	var radius = 20
#	draw_rect(spawn_area, Color(0.2,0.2,1.0,0.5))
#
#	for i in range(25):
#		draw_circle(spawn_enemy(),radius, Color.red)
