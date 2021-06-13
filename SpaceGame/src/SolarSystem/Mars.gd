extends KinematicBody2D


onready var size = Vector2($mars.texture.get_size())
onready var area = size.x * size.y
onready var rotation_speed = 10000 / area

var hp: float = 100.0
var velocity = Vector2()
var rotation_dir = -1
var movement = Vector2.ZERO
var gravity_index = Vector2(0.5, 0.5)


func _ready():
	$Label.text = "Area: " + str(area) + ", Size: " + str(size) + ", Rotation Speed: " + str(rotation_speed)
	#movement = AutoLoad.set_gravity($mars, area)


#func get_input():
	#movement = AutoLoad.get_update($mars)
	#velocity = movement * gravity_index


func _physics_process(delta):
	#get_input()
	rotation += rotation_dir * rotation_speed * delta
	#velocity = move_and_slide(velocity)
