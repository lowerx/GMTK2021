extends "res://src/SolarSystem/Planets.gd"

onready var size = Vector2($upiter.texture.get_size())


func _ready():
	get_margins(size)
	$Label.text = "Area: " + str(area) + ", Size: " + str(size) + ", Rotation Speed: " + str(rotation_speed)


func _physics_process(delta):
	rotation += rotation_dir * rotation_speed * delta
