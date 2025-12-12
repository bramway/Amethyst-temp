extends Node

var in_dialogue: bool = false
var dialogue_done = false
var curr_dialogue
var curr_dialogue_line
var curr_dialogue_sprite: Resource

func reset():
	in_dialogue = false
	dialogue_done = false
	curr_dialogue = null
	curr_dialogue_line = 0
	curr_dialogue_sprite = null
