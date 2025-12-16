extends Node

@onready var pause_menu_resource = load("res://scenes/Menus/pause_menu.tscn")

var instance = null

func pause():
	print("Pause!")
	if not is_paused():
		get_tree().paused = true
		instance = pause_menu_resource.instantiate()
		get_tree().root.add_child(instance)

func unpause():
	print("Unpause!")
	if is_paused():
		get_tree().paused = false
		instance.queue_free()
		instance = null

func is_paused():
	return (instance != null)

func toggle():
	if is_paused():
		unpause()
	else:
		pause()
