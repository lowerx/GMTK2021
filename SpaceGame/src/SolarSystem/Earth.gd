extends KinematicBody2D


export (int) var speed = 100
export (float) var rotation_speed = 0.5

onready var size = Vector2($coin.texture.get_width(), $coin.texture.get_height())
onready var area = size.x * size.y

var velocity = Vector2()
var rotation_dir = 1
var movement = Vector2.ZERO


func _ready():
	movement = AutoLoad.set_gravity($coin, area)


func get_input():
	velocity = movement


func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
