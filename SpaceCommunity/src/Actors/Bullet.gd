extends RigidBody2D


func _on_Area2D_body_entered(body):
	if not body.is_in_group("asteroids"):
		hide()
		queue_free()


func _on_Area2D_area_entered(area):
	if not area.is_in_group("asteroids"):
		hide()
		queue_free()
