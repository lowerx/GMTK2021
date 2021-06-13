extends RigidBody2D



func _on_Bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	hide()
	queue_free()


func _on_Bullet_body_entered(body):
	hide()
	queue_free()


func _on_Area2D_body_entered(body):
	hide()
	queue_free()


func _on_Area2D_area_entered(area):
	hide()
	queue_free()
