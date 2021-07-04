extends KinematicBody2D

var motion = Vector2()
var state = 0
# 0 - stops, 1 - right, 2 - left, 3 - up, 4 - down

func _physics_process(delta: float) -> void:
	
	
	if state == 0:
		pass
	elif state == 1:
		motion.x = 2000
	elif state == 2:
		motion.x = -2000
	elif state == 3:
		motion.y = -2000
	elif state == 4:
		motion.y == 2000
	move_and_slide(motion * delta)

func _on_timeout() -> void:
	state = floor(rand_range(0,5))
	print(state)
