extends RigidBody2D

signal damaged

export (int) var speed = 100

var hp: float
var colony_instance = {}
var goal_position = Vector2()
var velocity: Vector2 = Vector2.ZERO


func _ready():
	colony_instance = AutoLoad.get_colony()
	hp = colony_instance["hp"]
	goal_position = colony_instance["goal_position"]
	velocity = goal_position
	self.linear_velocity = velocity


func _physics_process(delta):
	_hp_check()
	$Label.text = str(hp) + "/100"
	_move_to_goal()


func _move_to_goal():
	if goal_position != position:
		velocity = goal_position
		self.linear_velocity = velocity


func _hp_check():
	if hp <= 0:
		queue_free()


func _on_ColonyArea_body_entered(body):
	if body.is_in_group("asteroids"):
		hp -= body.hp * 0.5
		emit_signal("damaged")
