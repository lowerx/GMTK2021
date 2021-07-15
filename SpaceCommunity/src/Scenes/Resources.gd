extends Node2D

const RESOURCES = [
	{
		"name": "gold",
		"object": preload("res://src/Objects/Gold.tscn")
	},
	{
		"name": "silver",
		"object": preload("res://src/Objects/Silver.tscn")
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
	screen_edges.append(0)
	screen_edges.append(get_viewport().size.x)
	screen_edges.append(get_viewport().size.y)


func _on_timeout():
	spawn_position = Vector2(
		round(rand_range(screen_edges[0], screen_edges[1])), 
		round(rand_range(screen_edges[0], screen_edges[2]))
	)
	
	var resource = RESOURCES[round(rand_range(0, RESOURCES.size() - 1))]["object"].instance()
	add_child(resource)
	
	resource.position = spawn_position
	
	AutoLoad.new_o_w_r(resource)
