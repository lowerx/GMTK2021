tool
extends Button

export(String, FILE) var next_scene_path: = ""


func _on_button_up() -> void:
	for planet in AutoLoad.planets:
		planet.hide()
	get_tree().change_scene(next_scene_path)
	get_tree().paused = false


func _get_configuration_warning() -> String:
	return "next_scene path must not be empty!" if next_scene_path == "" else ""
