extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ElementManager.Element.EARTH in ElementManager.unlocked_elements:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		ElementManager.unlocked_elements.append(ElementManager.Element.EARTH)
		queue_free()
