extends SubViewportContainer

@onready var death_screen_resource = load("res://scenes/Menus/death_screen.tscn")
@onready var pause_menu_resource = load("res://scenes/Menus/pause_menu.tscn")
var just_died = false
var pause_instance = null

func pause():
	print("Pause!")
	if not is_paused():
		get_tree().paused = true
		pause_instance = pause_menu_resource.instantiate()
		self.add_child(pause_instance)

func unpause():
	print("Unpause!")
	if is_paused():
		get_tree().paused = false
		pause_instance.queue_free()
		pause_instance = null

func is_paused():
	return (pause_instance != null)

func toggle():
	if is_paused():
		unpause()
	else:
		pause()

func _ready():
	$SubViewport/UI/LoadZoneBlack.color.a = 0
	Global.connect("health_change", display_death_if_dead)
	
func _input(_event):
	'''This paused all processes that are not in subviewportcontainer, so
	make sure your process is pausable when it should be, and not when it
	should not be. Level and DialogueScreen are set to pausable.'''
	if Input.is_action_just_pressed("Pause"):
		toggle()

func display_death_if_dead():
	if Global.player_health <= 0:# and just_died == false:
		#just_died = true
		var death_screen = death_screen_resource.instantiate()
		add_child(death_screen)


#func _process(_delta):
#	if Global.player_health <= 0 and just_died == false:
#		if get_tree().paused:
#			$Death_screen.queue_free()
#		else:
#			var death_screen = death_screen_resource.instantiate()
#			add_child(death_screen)
#	
#	if Global.load_screen == true:
#		$AnimationPlayer.play("load_fade")
#		Global.load_screen = false
