extends Node2D

const ASTEROID = preload("res://src/Objects/Asteroid.tscn")


func _ready() -> void:
	randomize()
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
