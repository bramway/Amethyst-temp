extends Node3D


const fireball_scene = preload("res://scenes/Spells/fireball.tscn")
const rock_scene = preload("res://scenes/Spells/rock.tscn")
const water_blast_scene = preload("res://scenes/Spells/water_blast.tscn")
const water_scene = preload("res://scenes/Spells/water.tscn")
const wind_blast_scene = preload("res://scenes/Spells/wind_blast.tscn")
const fire_scene = preload("res://scenes/Spells/fire.tscn")
var spell_direction: Vector2
var spell_position: Vector2
var FireScene = fire_scene.instantiate()
var mm = magic_math.new()

@export var ROCK_AMOUNT = 12
@export var WATER_AMOUNT = 8
@export var SPAWN_TIME = 0.01
@export var RANDOMNESS = 0.01
@export var CASTING_DISTANCE = 0.5
@export var SPELL_DELAY: float = 0.5
@export var SPELL_INPUT_BUFFERING_TIME: float = 0.2


# var selected_element: Element = Element.FIRE
var summon_list = []
var spell_queue: Array = []
var ready_to_cast: bool = true

@onready var root_node = $"../.."
@onready var player = $".."
@onready var summon_timer = $SummonTimer
@onready var spell_delay_timer = $SpellDelayTimer
@onready var camera = $"../PlayerCamera"



func _process(_delta):
	if Input.is_action_just_pressed("Fire") and ElementManager.Element.FIRE in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.FIRE
	if Input.is_action_just_pressed("Earth") and ElementManager.Element.EARTH in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.EARTH
	if Input.is_action_just_pressed("Water") and ElementManager.Element.WATER in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.WATER
	if Input.is_action_just_pressed("Wind") and ElementManager.Element.WIND in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.WIND
	
	if Input.is_action_just_pressed("Spell_1") or Input.is_action_just_pressed("Spell_2"):
		var pos_dir = mm.get_spell_direction(camera, get_viewport().get_visible_rect().size, get_viewport().get_mouse_position())
		spell_position = pos_dir[0]
		spell_direction	= pos_dir[1]
		
	if Input.is_action_just_pressed("Spell_1"):
		match ElementManager.player_selected_element:
			ElementManager.Element.FIRE:
				cast_spell(summon_in_direction, [fireball_scene, spell_direction])
			ElementManager.Element.EARTH:
				pass
			ElementManager.Element.WATER:
				cast_spell(summon_in_direction, [water_blast_scene, spell_direction])
			ElementManager.Element.WIND:
				cast_spell(summon_in_direction, [wind_blast_scene, spell_direction])
	
	if Input.is_action_just_pressed("Spell_2"):
		match ElementManager.player_selected_element:
			ElementManager.Element.FIRE:
				cast_spell(summon_at_position, [fire_scene, spell_position])
			ElementManager.Element.EARTH:
				pass
			ElementManager.Element.WATER:
				pass
			ElementManager.Element.WIND:
				cast_spell(player.dash, [spell_direction])
	
	if Input.is_action_just_pressed("Spell_3"):
		match ElementManager.player_selected_element:
			ElementManager.Element.FIRE:
				pass
			ElementManager.Element.EARTH:
				cast_spell(summon_rock, [])
			ElementManager.Element.WATER:
				cast_spell(summon_water, [])
			ElementManager.Element.WIND:
				pass





func summon_in_direction(scene: Object, direction: Vector2) -> void:
	var object = scene.instantiate()
	object.position = global_position + Vector3(direction.y, 0, direction.x) * CASTING_DISTANCE
	object.set("direction", direction)
	root_node.add_child(object)


func cast_spell(spell: Callable, args: Array) -> void:
	if ready_to_cast:
		spell.callv(args)
		ready_to_cast = false
		spell_delay_timer.start(SPELL_DELAY)
	elif spell_delay_timer.time_left < SPELL_INPUT_BUFFERING_TIME:
		spell_queue = [spell, args]


func dequeue_spell():
	if len(spell_queue) > 0:
		var spell = spell_queue[0]
		var args = spell_queue[1]
		spell_queue = []
		cast_spell(spell, args)


func _on_spell_delay_timer_timeout():
	ready_to_cast = true
	if len(spell_queue) > 0:
		dequeue_spell()


func summon_at_position(scene: Object, pos: Vector2) -> void:
	var object = scene.instantiate()
	object.position = global_position + Vector3(pos.y, 0, pos.x)
	root_node.add_child(object)


func summon_rock():
	'''summons rock in a circle by making a list of instances, then spawning them on summon timer'''
	var circle = mm.make_circle(ROCK_AMOUNT, 4)
	for i in range(len(circle)):
		var rock = rock_scene.instantiate()

		rock.position = global_position + (circle[i] * 1.5)
		summon_list.append(rock)
	summon_timer.start(SPAWN_TIME)


func summon_water():
	var circle = mm.make_circle(WATER_AMOUNT, 4)
	for i in range(len(circle)):
		var water = water_scene.instantiate()
		water.position = global_position + (circle[i] * 1.2)
		summon_list.append(water)
	summon_timer.start(SPAWN_TIME)



func _on_summon_timer_timeout():
	'''Pops all elements from summon lists and spawns them'''
	if summon_list != []:
		root_node.add_child(summon_list.pop_front())
		summon_timer.start(SPAWN_TIME + randf() * RANDOMNESS)
