extends Node3D

signal health_change

var load_screen = false
var player_pos: Vector3
var selected_element
var key_amount = 0
var player_health = 60:
	set(value):
		player_health = value
		health_change.emit()
var cheat_code_progress = 0
const CHEAT_CODE: Array[String] = ["END"] #["UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]

func _process(_delta: float) -> void:
	check_for_cheat_code()

func check_for_cheat_code():
	if cheat_code_progress == len(CHEAT_CODE):
		cheat_code_progress = 0
		print("Cheat code activated!")
		player_health = 100_000
		var Element = ElementManager.Element
		ElementManager.unlocked_elements = [Element.FIRE, Element.EARTH, Element.WATER, Element.WIND]
	elif Input.is_action_just_pressed(CHEAT_CODE[cheat_code_progress]):
		cheat_code_progress += 1
	elif cheat_code_progress == 0:
		pass
	elif Input.is_anything_pressed() and not Input.is_action_pressed(CHEAT_CODE[cheat_code_progress - 1]):
		cheat_code_progress = 0
