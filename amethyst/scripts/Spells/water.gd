extends Area3D

@onready var timer = $EventTimer

func _ready():
	timer.set_wait_time(2 + randf())
	timer.start()
	
func _process(_delta):
	if timer.time_left <= 0:
		queue_free()
