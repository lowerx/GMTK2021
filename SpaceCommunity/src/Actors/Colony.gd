extends KinematicBody2D

signal damaged

export (float) var speed = 0.1

var hp: float
var colony_instance = {}
var goal_position = Vector2()
var velocity: Vector2 = Vector2.ZERO


func _ready():
	colony_instance = AutoLoad.get_colony()
	hp = colony_instance["hp"]
	goal_position = colony_instance["goal_position"]


func _physics_process(delta):
	_hp_check()
	$Label.text = str(hp) + "/100"
	_move_to_goal()


func _move_to_goal():
	if (goal_position.x > position.x) and (goal_position.y > position.y):
		move_and_slide(
			Vector2(
				speed * goal_position.x,
				speed * goal_position.y
			)
		)
	elif (goal_position.x < position.x) and (goal_position.y < position.y):
		move_and_slide(
			Vector2(
				-speed * goal_position.x,
				-speed * goal_position.y
			)
		)
	elif (goal_position.x < position.x) and (goal_position.y > position.y):
		move_and_slide(
			Vector2(
				-speed * goal_position.x,
				speed * goal_position.y
			)
		)
	elif (goal_position.x > position.x) and (goal_position.y < position.y):
		move_and_slide(
			Vector2(
				speed * goal_position.x,
				-speed * goal_position.y
			)
		)
	else:
		move_and_slide(Vector2(0, 0))


func _hp_check():
	if hp <= 0:
		queue_free()


func _on_ColonyArea_body_entered(body):
	if body.is_in_group("asteroids"):
		hp -= body.hp * 0.5
		emit_signal("damaged")
