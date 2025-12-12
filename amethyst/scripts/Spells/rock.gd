extends RigidBody3D

@onready var animation = $AnimationPlayer
@onready var despawn_timer = $DespawnTimer
var blast = false
var dir_blast
@export var speed = 15
var direction
var impulse = false

func _ready():
	animation.play("rock_animation")
	
func apply_wind():
	apply_impulse(dir_blast * speed)
	impulse = true
	

	
func despawn():
	despawn_timer.start(1 + randf())

func _on_despawn_timer_timeout():
	queue_free()
	
func launch(attack, dir):
	if attack == 'rock':
		dir_blast =  Vector3(dir.y, 0.0, dir.x)
		apply_wind()
		despawn()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if impulse:
		if body.is_in_group("Enemies"):
			if body.has_method("take_damage"):
				body.take_damage('rock', direction)		
			queue_free()
