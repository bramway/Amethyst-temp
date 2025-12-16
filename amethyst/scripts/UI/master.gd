extends SubViewportContainer

@onready var death_screen_resource = load("res://scenes/Menus/death_screen.tscn")
var just_died = false

func _ready():
	$SubViewport/UI/LoadZoneBlack.color.a = 0
	
func _input(_event):
	'''This paused all processes that are not in subviewportcontainer, so
	make sure your process is pausable when it should be, and not when it
	should not be. Level and DialogueScreen are set to pausable.'''
	if Input.is_action_just_pressed("Pause"):
		print("input!")
		PauseManager.toggle()


func _process(_delta):
	if Global.player_health <= 0 and just_died == false:
		just_died = true
		if get_tree().paused:
			$Death_screen.queue_free()
		else:
			var death_screen = death_screen_resource.instantiate()
			add_child(death_screen)
	
	if Global.load_screen == true:
		$AnimationPlayer.play("load_fade")
		Global.load_screen = false
