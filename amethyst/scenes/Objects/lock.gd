extends Area3D

@export var unlocked: bool

func _process(_delta):
	if unlocked:
		$Lock/CollisionShape3D.disabled = true
	else:
		$Lock/CollisionShape3D.disabled = false
		
