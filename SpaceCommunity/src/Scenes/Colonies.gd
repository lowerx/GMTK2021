extends Node2D

var colony = preload("res://src/Actors/Colony.tscn")


func _process(delta):
	if AutoLoad.coins >= 100:
		if AutoLoad.check_colony():
			var r_colony = colony.instance()
			get_tree().get_root().add_child(r_colony)
			r_colony.global_position = AutoLoad.get_Earth_position()
			AutoLoad.add_colony(r_colony)
