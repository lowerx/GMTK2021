extends KinematicBody2D


onready var size = Vector2($coin.texture.get_width(), $coin.texture.get_height())
onready var area = size.x * size.y
onready var rotation_speed = 10000 / area

var velocity = Vector2()
var rotation_dir = -1
var movement = Vector2.ZERO
var gravity_index = Vector2(0.5, 0.5)


func _ready():
	movement = AutoLoad.set_gravity($coin, area)


func get_input():
	movement = AutoLoad.get_update($coin)
	velocity = movement


func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
