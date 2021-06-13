extends RigidBody2D


func _on_Area2D_body_entered(body):
	hide()
	queue_free()


func _on_Area2D_area_entered(area):
	hide()
	queue_free()
