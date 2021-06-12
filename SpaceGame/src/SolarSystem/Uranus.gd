extends KinematicBody2D


onready var size = Vector2($uranus.texture.get_size())
onready var area = size.x * size.y
onready var rotation_speed = 10000 / area

var hp: float = 100.0
var velocity = Vector2()
var rotation_dir = -1
var movement = Vector2.ZERO
var gravity_index = Vector2(0.5, 0.5)


func _ready():
	movement = AutoLoad.set_gravity($uranus, area)


func get_input():
	movement = AutoLoad.get_update($uranus)
	velocity = movement * gravity_index


func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
