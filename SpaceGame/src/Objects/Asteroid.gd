extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

var hp


func _ready():
	randomize()
	hp = rand_range(5, 30)
	var rand_scale = rand_range(0.1, 1.5)
	$AsteroidSprite.scale = Vector2(rand_scale, rand_scale)


func _process(delta):
	if hp <= 0:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	var velocity = Vector2(rand_range(min_speed, max_speed), 0)
	linear_velocity = velocity.rotated(1)


func _on_Area2D_area_entered(area):
	if area.get_name() == "BulletArea":
		hp -= 5
