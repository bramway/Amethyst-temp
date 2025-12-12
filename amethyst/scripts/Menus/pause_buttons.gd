extends Control

@onready var main_menu_resource = load("res://scenes/main_menu.tscn")
@onready var root = get_tree().get_root()

func _ready():
	get_tree().paused = true

func _exit_tree():
	get_tree().paused = false

func _on_start_button_pressed():
	get_tree().paused = not get_tree().paused
	queue_free()


func _on_options_button_pressed():
	print('not implemented!')


func _on_quit_button_pressed():
	get_tree().paused = false
	var curr_scene = root.get_child(root.get_child_count() -1)
	curr_scene.queue_free()
	var main_menu = main_menu_resource.instantiate()
	root.add_child(main_menu)
