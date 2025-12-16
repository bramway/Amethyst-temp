extends Node3D
class_name magic_math



var spell_position: Vector2
var spell_direction: Vector2

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
	
func get_spell_direction(camera, screen_size, mouse_position):
	"""Sets the spell_position and spell_direction variables."""
	var camera_position: Vector3 = camera.position
	var camera_angle_x: float = PI + camera.rotation.x # in radians
	var camera_vertical_fov_deg: float = camera.fov # in degrees
	var half_camera_vertical_fov: float = deg_to_rad(0.5 * camera_vertical_fov_deg)
	var d: float = 0.5 * screen_size.y / tan(half_camera_vertical_fov)
	var relative_mouse_position = (mouse_position - 0.5 * (screen_size))
	var mouse_direction_local := Vector3(relative_mouse_position.x, relative_mouse_position.y, d)
	var mouse_direction_global := Vector3(mouse_direction_local.x, cos(camera_angle_x) * mouse_direction_local.y - sin(camera_angle_x) * mouse_direction_local.z, sin(camera_angle_x) * mouse_direction_local.y + cos(camera_angle_x) * mouse_direction_local.z)
	mouse_direction_global *= (camera_position.y) / mouse_direction_global.y
	mouse_direction_global.z -= camera_position.z
	spell_position = Vector2(-mouse_direction_global.z, -mouse_direction_global.x)
	spell_direction = spell_position.normalized()
	var pos_dir = Array([spell_position, spell_direction])
	return pos_dir 

func make_line(direction, amount, length):
	var offset = length / amount
	var position_list = []
	position_list.append(Vector3(0,1,0))
	var perp = direction.rotated(PI/2)
	for _i in range(amount):
		var pos: Vector3
		pos.y = 1
		
		
