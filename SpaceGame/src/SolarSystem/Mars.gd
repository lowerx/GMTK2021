extends "res://src/SolarSystem/Planets.gd"

onready var size = Vector2($mars.texture.get_size())


func _ready():
	get_margins(size)
	$Label.text = "Hp:" + str(hp) + "Rotation Speed: " + str(rotation_speed)


func _physics_process(delta):
	$Label.text = "Hp:" + str(hp) + "Rotation Speed: " + str(rotation_speed)
	hp_check()
	rotation += rotation_dir * rotation_speed * delta


func _on_planet_body_entered(body):
	if body.is_in_group("asteroids"):
		hp -= 0.5 * body.hp
		body.queue_free()
