extends KinematicBody2D

const bullet_speed = 5000
var fire_rate = 3
var fire_time = 0.0

var bullet = preload("res://src/Actors/Bullet.tscn")

export var min_speed = 150.0
export var max_speed = 250.0

var hp
var planets = AutoLoad.planets
var goal = planets[rand_range(0, planets.size() - 1)]["object"] if planets.size() > 0 else null
var velocity = Vector2()


func _ready():
	randomize()
	planets = AutoLoad.planets
	if planets.size() > 0:
		goal = planets[rand_range(0, planets.size() - 1)]["object"]
		look_at(goal.get_position())
		velocity = goal.get_position() - get_position()
		velocity = velocity.normalized()
	hp = rand_range(5, 30)


func _process(delta):
	planets = AutoLoad.planets
	if goal == null:
		if planets.size() > 0:
			goal = planets[rand_range(0, planets.size() - 1)]
			look_at(goal.get_position())
			velocity = goal.get_position() - get_position()
			velocity = velocity.normalized()
	$EnemySprite.rotation_degrees = 90
	look_at(goal.get_position())
	velocity = move_and_slide(velocity).rotated(rotation)
	if hp <= 0:
		queue_free()
	shoot()


func _on_VisibilityNotifier2D_screen_exited():
	var velocity = Vector2(rand_range(min_speed, max_speed), 0)
	rotation += 1


func _on_Area2D_area_entered(area):
	if area.get_name() == "BulletArea":
		hp -= 5


func shoot():
	fire_rate = rand_range(3,15)
	if get_time() - fire_time < fire_rate:
		return
	fire_time = get_time()
	var bul = bullet.instance()
	bul.rotation_degrees = rotation_degrees + 90
	bul.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bul)
	bul.global_position = $FirePoint.global_position


func get_time():
	return OS.get_ticks_msec() / 1000
