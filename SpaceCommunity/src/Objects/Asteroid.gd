extends RigidBody2D

export var min_speed = 200.0
export var max_speed = 250.0

var hp


func _ready():
	randomize()
	var rand_scale = rand_range(0.1, 1.5)
	$AsteroidSprite.scale = Vector2(rand_scale, rand_scale)
	$AsteroidArea/CollisionShape2D2.scale = Vector2(rand_scale, rand_scale)
	$CollisionShape2D.scale = Vector2(rand_scale, rand_scale)
	hp = rand_scale * 30


func _process(delta):
	if hp <= 0:
		queue_free()
	$Label.text = str(hp)


func _on_VisibilityNotifier2D_screen_exited():
	var velocity = Vector2(rand_range(min_speed, max_speed), 0)
	linear_velocity = velocity.rotated(1)


func _on_AsteroidArea_body_entered(body):
	if body.is_in_group("bullets") or body.is_in_group("enemybullets"):
		hp -= 15
		body.queue_free()
