extends Area3D

@export var unlocked: bool


func play_sound():
	$AudioStreamPlayer.play()
	
func _process(_delta):
	if unlocked:
		$Lock/CollisionShape3D.disabled = true
		
	else:
		$Lock/CollisionShape3D.disabled = false
		
