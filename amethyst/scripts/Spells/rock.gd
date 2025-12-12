extends RigidBody3D

@onready var animation = $AnimationPlayer
@onready var despawn_timer = $DespawnTimer

func _ready():
	animation.play("rock_animation")
	
func despawn():
	despawn_timer.start(1 + randf())

func _on_despawn_timer_timeout():
	queue_free()
