extends Node

enum Element {
	DARKNESS,
	EARTH,
	FIRE,
	LIGHT,
	WATER,
	WIND
}

var player_selected_element: Element = Element.FIRE
var unlocked_elements: Array[Element] = [Element.FIRE]
