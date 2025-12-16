extends Control

@onready var level_resource = load("res://scenes/UI/viewport.tscn")
@onready var scoreboard_resource = load("res://scenes/UI/scoreboard_display.tscn")
@onready var root = get_tree().get_root()
	
	
func _on_start_button_pressed():
	'''To understand this script, know that the level we are in is just a child of the godot "root". 
	in this script I am removing the current child (Main menu level) and adding the first level child.
	To do this I have preloaded the resources above.'''
	
	queue_free()
	var level = level_resource.instantiate()
	root.add_child(level)


func _on_options_button_pressed():
	print('not implemented yet!')


func _on_scoreboard_button_pressed():
	var curr_scene = root.get_child(root.get_child_count() - 1)
	curr_scene.queue_free()
	var scoreboard = scoreboard_resource.instantiate()
	root.add_child(scoreboard)


func _on_quit_button_pressed():
	'''Just quits the game lol'''
	get_tree().quit()
