extends StaticBody2D

export var gravity_index: Vector2 = Vector2(0.5, 0.5)

onready var size = Vector2($sun.texture.get_width(), $sun.texture.get_height())
onready var area = size.x * size.y * 1000


func _ready():
	$Label.text = "Area: " + str(area) + ", Size: " + str(size)
	#AutoLoad.set_sun($sun, area)
