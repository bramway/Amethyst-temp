extends Area3D

@onready var timer = $EventTimer
var direction = Vector2.ZERO

func _ready():
	timer.set_wait_time(2 + randf())
	timer.start()
	
func _process(_delta):
	if timer.time_left <= 0:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		if body.has_method("take_damage"):
			body.take_damage('water', direction)		
		queue_free()
