extends Node

@export var caster: spell_caster
@export var summoner: summon_manager
@onready var camera = $"../PlayerCamera"
@onready var spell_pos: Vector2
@onready var spell_dir: Vector2
const player_fired: bool = true


var mm := magic_math.new()

func _process(_delta):
	_handle_element_selection()
	_handle_spell_input()



func _handle_element_selection():
	if Input.is_action_just_pressed("Fire") and ElementManager.Element.FIRE in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.FIRE

	if Input.is_action_just_pressed("Earth") and ElementManager.Element.EARTH in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.EARTH

	if Input.is_action_just_pressed("Water") and ElementManager.Element.WATER in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.WATER

	if Input.is_action_just_pressed("Wind") and ElementManager.Element.WIND in ElementManager.unlocked_elements:
		ElementManager.player_selected_element = ElementManager.Element.WIND



func _handle_spell_input():
	if not (
		Input.is_action_just_pressed("Spell_1")
		or Input.is_action_just_pressed("Spell_2")
		or Input.is_action_just_pressed("Spell_3")
	):
		return

	var pos_dir = mm.get_spell_direction(
		camera,
		get_viewport().get_visible_rect().size,
		get_viewport().get_mouse_position()
	)

	spell_pos = pos_dir[0]
	spell_dir = pos_dir[1]

	if Input.is_action_just_pressed("Spell_1"):
		_cast_spell_1(spell_dir)

	elif Input.is_action_just_pressed("Spell_2"):
		_cast_spell_2(spell_pos, spell_dir)

	elif Input.is_action_just_pressed("Spell_3"):
		_cast_spell_3(spell_pos, spell_dir)



func _cast_spell_1(direction: Vector2):
	var origin = get_parent().global_position
	match ElementManager.player_selected_element:
		ElementManager.Element.FIRE:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.fireball_scene, origin, direction, player_fired, false]
			)

		ElementManager.Element.EARTH:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.rock_scene, origin, direction, player_fired, true]
			)

		ElementManager.Element.WATER:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.water_blast_scene, origin, direction, player_fired, false]
			)

		ElementManager.Element.WIND:
			caster.try_cast(
				summoner.summon_in_direction,
				[summoner.wind_blast_scene, origin, direction, player_fired, false]
			)



func _cast_spell_2(position: Vector2, direction: Vector2):
	var origin = get_parent().global_position
	match ElementManager.player_selected_element:
		ElementManager.Element.FIRE:
			caster.try_cast(
				summoner.summon_at_position,
				[summoner.fire_scene, origin, position]
			)

		ElementManager.Element.EARTH:
			caster.try_cast(
				summoner.summon_at_position,
				[summoner.rock_scene, origin, position]
			)

		ElementManager.Element.WATER:
			pass

		ElementManager.Element.WIND:
			caster.try_cast(
				get_parent().dash,
				[direction]
			)


func _cast_spell_3(_position: Vector2, direction: Vector2):
	var origin = get_parent().global_position
	match ElementManager.player_selected_element:
		ElementManager.Element.FIRE:
			pass

		ElementManager.Element.EARTH:
			caster.try_cast(
				summoner.summon_line,
				[summoner.rock_scene, origin, direction, 6, 4, false]
			)

		ElementManager.Element.WATER:
			caster.try_cast(
				summoner.summon_circle,
				[summoner.water_scene, origin, summoner.WATER_AMOUNT, 2, 4]
			)

		ElementManager.Element.WIND:
			pass
