extends CharacterBody3D

@onready var hit_timer = $Timer
@onready var range_timer = $Range_Timer
@onready var summoner =$summon_manager
@onready var caster = $spell_caster

var movement_speed = 3
var player_nearby: bool = false
var touching: bool = false
@export var max_health: int 
var blast = false
var health: int
var dir_blast 
@export var animation: Node
@export var animation_name: String
@export var stationary: bool
@export var fireball_damage : int
@export var fire_damage: int
@export var waterblast_damage: int
@export var waterblast_movement: float
@export var blast_speed: float
@export var rock: int
var water_speed_boost = false
var mm = magic_math.new()

enum ElementType {
	FIRE,
	EARTH,
	WATER,
	WIND
}

@export var element: ElementType = ElementType.FIRE


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
	health = max_health
	hit_timer.timeout.connect(hit)
	range_timer.timeout.connect(range_attack)
	$HealthBar3D/SubViewport/enemyhealthbar.max_value = max_health
	set_health_bar()
	if animation:
		animation.play(animation_name)
	


func set_health_bar():
	$HealthBar3D/SubViewport/enemyhealthbar.value = health
	
	
func take_damage(attack, direction):
	if attack == 'Fireball':
		health -= fireball_damage
	if attack == 'fire':
		health -= fire_damage
	if attack == 'windblast':
		blast = true
		$Blast_Timer.start()
		dir_blast = direction
	if attack == 'waterblast' or attack == 'water':
		if not water_speed_boost:
			movement_speed *= waterblast_movement
		health -= waterblast_damage
		$Water_Timer.start()
		water_speed_boost = true
	if attack == 'rock':
		health -= rock
	
	set_health_bar()
	if health <= 0:
		queue_free()
		
func hit():
	Global.player_health -= 5
	
func range_attack():
	var dir3 = (Global.player_pos - global_position).normalized()
	var direction = Vector2(dir3.z, dir3.x).normalized()
	const player_fired: bool = false
	match element:
		ElementType.FIRE:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.fireball_scene, global_position, direction, player_fired]
			)
		ElementType.EARTH:
			pass
		ElementType.WATER:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.water_blast_scene, global_position, direction, player_fired]
			)
		ElementType.WIND:
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
	water_speed_boost = false


func _on_range_area_body_entered(body: Node3D) -> void:
	if stationary:
		if body.name == 'Player':
			range_timer.start()
			range_attack()
		
			


func _on_range_area_body_exited(body: Node3D) -> void:
	if stationary:
		if body.name == 'Player':
			range_timer.stop()
			
