extends Node


func _unhandled_input(event):
	get_tree().paused = false
	get_tree().change_scene("res://src/Screens/MainScreen.tscn")
