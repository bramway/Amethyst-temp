extends Node

enum Element {
	DARKNESS,
	EARTH,
	FIRE,
	LIGHT,
	WATER,
	WIND,
	NULL
}

var player_selected_element: Element = Element.NULL
var unlocked_elements: Array[Element] = []
