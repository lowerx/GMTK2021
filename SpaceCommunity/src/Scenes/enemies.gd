extends Node2D

const width = 1910
const height = 1060
const ENEMY = preload("res://src/Actors/Enemy.tscn")


func _ready() -> void:
	randomize()
	get_tree().call_group("enemy", "queue_free")
	$Timer.start()


func _on_Timer_timeout():
	var enemy_spawn_location = $Path2D/PathFollow2D
	enemy_spawn_location.unit_offset = randf()
	
	var enemy = ENEMY.instance()
	add_child(enemy)
	
	enemy.position = enemy_spawn_location.position
	
	var direction = enemy_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.move_and_slide(velocity.rotated(direction))
