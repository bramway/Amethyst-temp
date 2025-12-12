class_name Magic_forms

func make_circle(amount, layer):
	'''makes a normalized vector circle list with given amount of positions, can have multiple circles with complexity'''
	var position_list = []
	for i in range(layer):
		for j in range(amount):
			var pos: Vector3
			pos.x = cos(2 * PI * (i + j)/amount)
			pos.z = sin(2 * PI * (i + j)/amount)
			
			var pos_rotated = pos.rotated(Vector3(0, 1, 0), (i * PI / amount)) * (0.2 * i + 1)
			position_list.append(pos_rotated)
	return position_list
