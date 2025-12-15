class_name spell_caster
extends Node

@export var SPELL_DELAY := 0.5
@export var INPUT_BUFFER_TIME := 0.2

var castable := true
var buffered_spell: Array = []

@onready var delay_timer := Timer.new()

func _ready():
	add_child(delay_timer)
	delay_timer.one_shot = true
	delay_timer.timeout.connect(_on_delay_timeout)

func try_cast(spell: Callable, args: Array = []):
	if castable:
		castable = false
		delay_timer.start(SPELL_DELAY)
		return spell.callv(args)
	elif delay_timer.time_left < INPUT_BUFFER_TIME:
		buffered_spell = [spell, args]

func _on_delay_timeout():
	castable = true
	if not buffered_spell.is_empty():
		var spell = buffered_spell[0]
		var args = buffered_spell[1]
		buffered_spell.clear()
		try_cast(spell, args)
