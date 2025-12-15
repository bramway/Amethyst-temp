extends Node3D

@onready var fire_tick = $FireTickTimer
@onready var despawn_timer = $DespawnTimer
var seen = false
var enemies: Array = []
var direction: Vector2
@export var FIRE_DESPAWN_TIMER: float = 5


func _ready():
	fire_tick.timeout.connect(hit)
	despawn_timer.start(FIRE_DESPAWN_TIMER)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		if body.has_method("take_damage"):
			seen = true
			enemies.append(body)
			hit()
			fire_tick.start()	


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		if body.has_method("take_damage"):
			fire_tick.stop()
			enemies.erase(body)	


func hit():
	for enemy in enemies:	
		enemy.take_damage('fire', direction)	
		print('hit')


func _on_despawn_timer_timeout() -> void:
	queue_free()
