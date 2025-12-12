extends Control

@onready var main_menu_resource = load("res://scenes/main_menu.tscn")
@onready var root = get_tree().get_root()



func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	var curr_scene = root.get_child(root.get_child_count() -1)
	curr_scene.queue_free()
	var main_menu = main_menu_resource.instantiate()
	root.add_child(main_menu)
	Global.player_health = 60



func _on_respawn_pressed() -> void:
	print('not implemented')
