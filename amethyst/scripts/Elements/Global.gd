extends Node3D

signal health_change

enum Element {
	DARKNESS,
	EARTH,
	FIRE,
	LIGHT,
	WATER,
	WIND
}

var player_pos: Vector3
var selected_element
var player_health = 60:
	set(value):
		player_health = value
		health_change.emit()
