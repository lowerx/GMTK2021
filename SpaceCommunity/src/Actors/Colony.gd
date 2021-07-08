extends KinematicBody2D

signal damaged

export (int) var speed = 400

var hp: float
var colony_instance = {}
var goal_position = Vector2()
var velocity = Vector2()


func _ready():
	colony_instance = AutoLoad.get_colony()
	hp = colony_instance["hp"]
	goal_position = colony_instance["goal_position"]


func get_input():
	look_at(goal_position)
	velocity = Vector2(speed, 0)


func _physics_process(delta):
	_hp_check()
	$Label.text = str(hp) + "/100"
	get_input()
	velocity = move_and_slide(velocity)


func _hp_check():
	if hp <= 0:
		queue_free()


func _on_ColonyArea_body_entered(body):
	if body.is_in_group("asteroids"):
		hp -= body.hp * 0.5
		emit_signal("damaged")
