extends Control

@onready var main_menu_resource = load("res://scenes/Menus/main_menu.tscn")
@onready var root = get_tree().get_root()
@onready var level_resource = load("res://scenes/UI/viewport.tscn")

func _ready():
	get_tree().paused = true

func _exit_tree():
	get_tree().paused = false

func _on_main_menu_pressed() -> void:
	Global.player_health = 60
	get_parent().queue_free()
	queue_free()

func _on_respawn_pressed() -> void:
	print('Not Implemented')
