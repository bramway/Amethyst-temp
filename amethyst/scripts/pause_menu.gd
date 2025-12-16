extends Control

@onready var root = get_tree().get_root()

func _ready():
	self.get_parent().pause()

func _exit_tree():
	self.get_parent().unpause()

func _on_start_button_pressed():
	#get_tree().paused = not get_tree().paused
	queue_free()

func _on_options_button_pressed():
	print('not implemented!')

func _on_quit_button_pressed():
	#var curr_scene = root.get_child(root.get_child_count() -1)
	#curr_scene.queue_free()

	self.get_parent().queue_free()
	queue_free()
