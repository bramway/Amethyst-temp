class_name summon_manager
extends Node

@export var CAST_DISTANCE := 0.5
@export var SPAWN_TIME := 0.01
@export var RANDOMNESS := 0.01
@export var ROCK_AMOUNT: int
@export var WATER_AMOUNT: int

@export var fireball_scene: PackedScene
@export var rock_scene: PackedScene
@export var water_scene: PackedScene
@export var fire_scene: PackedScene
@export var water_blast_scene: PackedScene
@export var wind_blast_scene: PackedScene


var summon_list := []
var mm := magic_math.new()

@onready var summon_timer := Timer.new()

func _ready():
	add_child(summon_timer)
	summon_timer.timeout.connect(_on_summon_timer_timeout)

func summon_in_direction(scene: PackedScene, origin: Vector3, direction: Vector2, player_fired: bool):
	var obj = scene.instantiate()
	obj.position = origin + Vector3(direction.y, 0, direction.x) * CAST_DISTANCE
	obj.set("direction", direction)
	obj.set('player_fired', player_fired)
	get_tree().root.add_child(obj)
	return obj

func summon_at_position(scene: PackedScene, origin: Vector3, pos: Vector2):
	var obj = scene.instantiate()
	obj.position = origin + Vector3(pos.y, 0, pos.x)
	if obj.name == 'Rock_body':
		var obj_pos = obj.position
		summon_circle(scene, obj_pos, ROCK_AMOUNT, 1.5, 2)
	else:
		get_parent().get_parent().add_child(obj)
	return obj

func summon_circle(scene: PackedScene, origin: Vector3, amount: int, radius: float, layer: int):
	var circle = mm.make_circle(amount, layer)
	for p in circle:
		var obj = scene.instantiate()
		obj.position = origin + p * radius
		summon_list.append(obj)
	summon_timer.start(SPAWN_TIME)

func _on_summon_timer_timeout():
	if summon_list.is_empty():
		return
	get_parent().get_parent().add_child(summon_list.pop_front())
	summon_timer.start(SPAWN_TIME + randf() * RANDOMNESS)
	
