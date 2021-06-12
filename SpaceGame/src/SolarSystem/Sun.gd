extends StaticBody2D

export var gravity_index: Vector2 = Vector2(0.5, 0.5)

onready var size = Vector2($sun.texture.get_width(), $sun.texture.get_height())
onready var area = size.x * size.y


func _ready():
	AutoLoad.set_sun($sun, area)
