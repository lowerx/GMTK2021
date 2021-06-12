extends Node

signal update


var planets = []
var movements = []


func set_gravity(object, area):
	planets.append({"object": object, "area": area})
	_set_event()
	return get_update(object)


func get_update(object):
	for item in range(0, movements.size()):
		if object == movements[item]["object"]:
			var movement = movements[item]["movement"]
			movements.remove(item)
			return movement


func _set_event():
	var objects_positions = []
	for item in planets:
		objects_positions.append(
			{
				"object": item["object"], 
				"position": _get_objects_position(item["object"]),
				"area": item["area"]
			}
		)
	for item in planets:
		var positions = []
		var self_position
		var self_area
		for object in range(0, objects_positions.size()):
			if objects_positions[object]["object"] == item["object"]:
				self_position = objects_positions[object]["position"]
				self_area = objects_positions[object]["area"]
			else:
				positions.append(objects_positions[object])
		
		var other_positions = []
		for object in range(0, round(float(positions.size()) / 2)):
			if positions[object]["object"] == item["object"]:
				self_position = positions[object]["position"]
				self_area = positions[object]["area"]
			else:
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
				movements.append({
					"object": item["object"],
					"movement": saver[0] if saver.size() > 0 else Vector2.ZERO
				})
				break
	emit_signal("update")


func _get_objects_position(object):
	return object.get_position()


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
	if area2 > self_area:
		area2max = area2
		area2min = self_area
	else:
		area2max = self_area
		area2min = area2
	movement.x = position2.x + (position1.x - position2.x) * area1max * area2min * (position1.x - self_position.x) / (area1min * area2max * (position2.x - self_position.x))
	movement.y = position2.y + (position1.y - position2.y) * area1max * area2min * (position1.y - self_position.y) / (area1min * area2max * (position2.y - self_position.y))
	var area = area2max * area1min / (area1max * area2min)
	return [movement, area]
