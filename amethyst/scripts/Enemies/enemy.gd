extends CharacterBody3D

@onready var hit_timer = $Timer

var movement_speed = 3
var player_nearby: bool = false
var touching: bool = false
const max_health = 100
var health = max_health
var blast = false
const blast_speed = 15
var dir_blast 
@export var animation: Node
@export var animation_name: String
@export var stationary: bool

func _process(_delta):
	if player_nearby:
		if not stationary:
			var dir = (Global.player_pos-global_position).normalized()
			velocity.x = dir.x * movement_speed
			velocity.z = dir.z * movement_speed
			velocity.y = -9
			move_and_slide()
	if blast:
		velocity.x = dir_blast.y * blast_speed
		velocity.z = dir_blast.x * blast_speed 
		move_and_slide()
		
		
	
func _ready():
	hit_timer.timeout.connect(hit)
	#range_timer.timeout.connect(range_attack)
	$HealthBar3D/SubViewport/enemyhealthbar.max_value = max_health
	set_health_bar()
	if animation:
		animation.play(animation_name)


func set_health_bar():
	$HealthBar3D/SubViewport/enemyhealthbar.value = health
	
func take_damage(attack, direction):
	if attack == 'Fireball':
		health -= 5
	if attack == 'fire':
		health -= 5
	if attack == 'windblast':
		blast = true
		$Blast_Timer.start()
		dir_blast = direction
	if attack == 'waterblast':
		movement_speed = 1.5
		$Water_Timer.start()
	set_health_bar()
	if health <= 0:
		queue_free()
		
func hit():
	Global.player_health -= 5
	
func range_attack():
	pass
	
func die():
	queue_free()
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		player_nearby = true
	


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		player_nearby = false
		


func _on_damage_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":	
		hit()
		hit_timer.start()
		

func _on_damage_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		hit_timer.stop()


func _on_blast_timer_timeout() -> void:
	blast = false
	dir_blast = Vector2.ZERO


func _on_water_timer_timeout() -> void:
	movement_speed = 3
