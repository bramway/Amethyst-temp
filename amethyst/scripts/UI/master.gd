extends SubViewportContainer

@onready var pause_menu_resource = load("res://scenes/Menus/pause_menu.tscn")
@onready var death_screen_resource = load("res://scenes/Menus/death_screen.tscn")
var just_died = false


func _input(_event):
	'''This paused all processes that are not in subviewportcontainer, so make
	sure your process is pausable when it should be, and not when it should not
	be. Level and DialogueScreen are set to pausable.'''
	if Input.is_action_just_pressed("Pause"):
		
		if get_tree().paused:
			$PauseMenu.queue_free()
		else:
			var pause_menu = pause_menu_resource.instantiate()
			add_child(pause_menu)

func _process(_delta):
	if Global.player_health <= 0 and just_died == false:
		just_died = true
		if get_tree().paused:
			$Death_screen.queue_free()
		else:
			var death_screen = death_screen_resource.instantiate()
			add_child(death_screen)
		get_tree().paused = not get_tree().paused
