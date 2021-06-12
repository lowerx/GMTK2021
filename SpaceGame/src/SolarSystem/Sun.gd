extends StaticBody2D

export var gravity_index: Vector2 = Vector2(0.5, 0.5)

onready var size = Vector2($coin.texture.get_width(), $coin.texture.get_height())
onready var area = size.x * size.y


func _ready():
	AutoLoad.set_sun($coin, area)
