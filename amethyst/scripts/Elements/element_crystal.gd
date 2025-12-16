extends Area3D

enum Pickup {
	ELEMENT,
	KEY,
	HEALTH
}

@export var pickup_type: Pickup
@export var element_type: ElementManager.Element
@export var health_amount: int

func _ready() -> void:
	
	match pickup_type:
		Pickup.ELEMENT:
			if element_type in ElementManager.unlocked_elements:
						queue_free()
			$CrystalSprite.frame = element_type
				
		Pickup.KEY:
			$CrystalSprite.frame = 3 #Key frame!
	
func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		match pickup_type:
			Pickup.ELEMENT:
				ElementManager.unlocked_elements.append(element_type)
			Pickup.KEY:
				Global.key_amount += 1
				print(Global.key_amount)
				
			Pickup.HEALTH:
				print('not implemented yet')
				
			_:
				print('incorrect pickup type')
					
		queue_free()
