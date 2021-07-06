extends RigidBody2D

export var min_speed = 200.0
export var max_speed = 250.0


func _ready():
	randomize()
	var rand_scale = rand_range(0.1, 1.5)
	scale = Vector2(rand_scale, rand_scale)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_MenuAsteroidSprite_pressed():
	queue_free()
