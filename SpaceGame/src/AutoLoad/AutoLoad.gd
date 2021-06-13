extends Node

signal update


var planets = []


func set_sun(object, area):
	planets.append({"type": "sun", "object": object, "area": area})
	get_update(object)


func set_gravity(object, area):
	planets.append({"type": "planet", "object": object, "area": area})
	get_update(object)


func get_update(object):
	_update_objects_positions()
	var index = _get_object_index(object)
	return _set_movement(index)


func _get_object_index(object):
	for index in range(0, planets.size()):
		if planets[index]["object"] == object:
			return index


func _set_movement(index):
	var movement = {}
	if planets[index]["type"] != "sun":
		var positions = []
		var self_position = planets[index]["position"]
		var self_area = planets[index]["area"]
		for object in range(0, planets.size()):
			if object != index:
				if planets[object]["area"] > self_area:
					positions.append(planets[object])
		
		var other_positions = []
		for object in range(0, round(float(positions.size()) / 2)):
			if positions[object]["object"] == positions[positions.size() - 1]["object"]:
				if float(positions.size() % 2) != 0:
					other_positions.append({
						"vector": [
							positions[object]["position"],
							positions[positions.size() - 1 - object]["position"]
						],
						"areas": [
							positions[object]["area"],
							positions[positions.size() - 1 - object]["area"]
						]
					})
				else:
					other_positions.append({
						"vector": [
							positions[object]["position"],
							positions[object - 1]["position"]
						],
						"areas": [
							positions[object]["area"],
							positions[object - 1]["area"]
						]
					})
			else:
				other_positions.append({
					"vector": [
						positions[object]["position"],
						positions[positions.size() - 1 - object]["position"]
					],
					"areas": [
						positions[object]["area"],
						positions[positions.size() - 1 - object]["area"]
					]
				})
		while true:
			var result_array = []
			var saver = []
			for object in other_positions:
				if saver != []:
					var saver2 = _get_movement(self_position, object["vector"][0], object["vector"][1], self_area, object["areas"][0], object["areas"][1])
					result_array.append({
						"vector": [
							saver[0],
							saver2[0]
						],
						"areas": [
							saver[1],
							saver2[1]
						]
					})
					saver = []
				else:
					saver = _get_movement(self_position, object["vector"][0], object["vector"][1], self_area, object["areas"][0], object["areas"][1])
			if result_array.size() > 0:
				other_positions = result_array
			else:
				return saver[0] if saver.size() > 0 else Vector2.ZERO


func _update_objects_positions():
	for item in planets:
		item["position"] = item["object"].get_position()


func _get_movement(self_position, position1, position2, self_area, area1, area2):
	var movement = Vector2()
	var area1max
	var area1min
	var area2max
	var area2min
	if area1 > self_area:
		area1max = area1
		area1min = self_area
	else:
		area1max = self_area
		area1min = area1
	var v_first = (area1max - area1min) / sqrt((position1.x - self_position.x) * (position1.x - self_position.x) + (position1.y - self_position.y) * (position1.y - self_position.y))
	if area2 > self_area:
		area2max = area2
		area2min = self_area
	else:
		area2max = self_area
		area2min = area2
	var v_second = (area2max - area2min) / sqrt((position2.x - self_position.x) * (position2.x - self_position.x) + (position2.y - self_position.y) * (position2.y - self_position.y))
	movement.x = position2.x + (position1.x - position2.x) * v_second / v_first
	movement.y = position2.y + (position1.y - position2.y) * v_second / v_first
	var area = area2max * area1min / (area1max * area2min)
	return [movement, area]
