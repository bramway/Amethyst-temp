extends Area3D

@export var element_type: String

var string_to_properties: Dictionary = { #As we are using foreign enums, better to keep the anims close to home
	"WATER": [ElementManager.Element.WATER, 2],
	"EARTH": [ElementManager.Element.EARTH, 1],
	"FIRE": [ElementManager.Element.FIRE, 0],
	"WIND": [ElementManager.Element.WIND, 3]
}

func _ready() -> void:
	element_type = element_type.to_upper()
	
	if string_to_properties[element_type][0] in ElementManager.unlocked_elements:
				queue_free()
				
	$CrystalSprite.frame = string_to_properties[element_type][1]
	
func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print('yawoo')
		ElementManager.unlocked_elements.append(string_to_properties[element_type][0])
		queue_free()
