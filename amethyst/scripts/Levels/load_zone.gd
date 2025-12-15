'''Do note that the collissionshape and meshinstance are children NOT in the loadzone scene but in the level scene.
This is so that you can scale different loadzones in different levels differently'''

extends Area3D

@export var goto_zone_resource: String
@export var load_id: int
@onready var root = get_tree().get_root()
@onready var curr_level = get_tree()

func _on_body_entered(body):
	'''Bases the level based on the parent of the player, probably not a good principle, but it works
	'''
	if body.name == "Player":
		switch_level(body)

func switch_level(body):
	'''Does a scoobeedoo and replaces the current level with the next level'''
	var curr_scene = body.get_parent()
	var scene_parent = curr_scene.get_parent()
	curr_scene.queue_free()
	var new_level = load(goto_zone_resource).instantiate()
	new_level.process_mode = PROCESS_MODE_PAUSABLE
	scene_parent.add_child(new_level)
	move_player(new_level)
	
func move_player(level: Node):
	'''matches spawn_location id with load_id so it can get the proper location, then puts the new player there.'''
	for node in level.get_children():
		if "spawn_id" in node and node.spawn_id == load_id:
			var player = level.find_child("Player")
			player.global_position = node.global_position
			
