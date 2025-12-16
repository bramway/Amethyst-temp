extends Node

@export var CHARACTERS_PER_SECOND: int = 100
@onready var text_node = $DialogueText
@onready var text_box = $DialogueBox
@onready var text_sprite = $Sprite2D
@onready var letter_timer = $LetterTimer


func _process(_delta):
	'''Checks data type, controls if dialogue is possible and then types the text. This should be refactored likely.
	There is currently a bug where if you are constantly in ANY area, it advances the text of arrays even though it shouldnt'''
	var text = type_interpret(Dialogue.curr_dialogue)
	if Input.is_action_just_pressed("Dialogue"):
		if Dialogue.curr_dialogue != null:
			if Dialogue.in_dialogue:
				get_tree().paused = false
				self.visible = false
				Dialogue.in_dialogue = false
			else:
				get_tree().paused = true
				read(text)
				Dialogue.in_dialogue = true
				if Dialogue.dialogue_done:
					if typeof(Dialogue.curr_dialogue) == TYPE_ARRAY:
						Dialogue.curr_dialogue_line = (Dialogue.curr_dialogue_line + 1) % len(Dialogue.curr_dialogue)
					Dialogue.dialogue_done = false
						
				
	if Dialogue.curr_dialogue == null:
		Dialogue.curr_dialogue_line = 0
	else:
		reveal_text(text)
		
		
func reveal_text(text):
	'''This displays the text letter by letter based on characters_per_second'''
	var revealed_text = len(text) - (CHARACTERS_PER_SECOND * letter_timer.time_left)
	if revealed_text < 0:
		revealed_text = 0
	text_node.text = text.substr(0, revealed_text)
	
			
		
func type_interpret(text):
	'''Currently interprets strings and arrays, could also support dictionary with the right scripts!'''
	match typeof(text):
		TYPE_STRING:
			return text
		TYPE_ARRAY:
			return text[Dialogue.curr_dialogue_line]
		_:
			return ""

func read(text):
	'''makes the text and sprite visible and starts the text speed timer'''
	self.visible = true
	if Dialogue.curr_dialogue_sprite != null:
		text_sprite.texture = Dialogue.curr_dialogue_sprite
		
	letter_timer.start(float(len(text) / float(CHARACTERS_PER_SECOND))) #floats otherwise it intdivs
	
	
func _on_letter_timer_timeout():
	Dialogue.dialogue_done = true #This is to make sure the array text doesn't cycle through weirdly
