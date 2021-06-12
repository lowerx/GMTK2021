extends Button

func _on_button_up() -> void:
	AutoLoad.planets = []
	get_tree().quit()
