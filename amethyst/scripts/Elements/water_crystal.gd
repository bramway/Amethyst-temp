extends Area3D

@onready var element_manager = $"../../ElementManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if element_manager.Element.WATER in element_manager.unlocked_elements:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		element_manager.unlocked_elements.append(element_manager.Element.WATER)
		queue_free()
