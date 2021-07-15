extends Node2D

const RESOURCES = [
	{
		"name": "gold",
		"object": preload("res://src/Objects/Gold.tscn")
	},
	{
		"name": "argentum",
		"object": preload("res://src/Objects/Argentum.tscn")
	},
	{
		"name": "platinum",
		"object": preload("res://src/Objects/Platinum.tscn")
	}
]

var spawn_position = Vector2.ZERO

var screen_edges : Array = []


func _ready():
	randomize()
	screen_edges.append(Vector2.ZERO)
	screen_edges.append(Vector2(get_viewport().size.x, 0))
	screen_edges.append(Vector2(0, get_viewport().size.y))


func _on_timeout():
	spawn_position = Vector2(
		round(rand_range(screen_edges[0], screen_edges[1])), 
		round(rand_range(screen_edges[0], screen_edges[2]))
	)
	spawn_position.unit_offset = randf()
	
	var resource = RESOURCES[round(rand_range(0, RESOURCES.size()))]["object"].instance()
	add_child(resource)
	
	resource.position = spawn_position.position
	
	var direction = spawn_position.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	resource.rotation = direction
	
	AutoLoad.new_o_w_r(resource)
