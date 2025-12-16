extends CharacterBody3D

const MOVEMENT_SPEED = 5
const SPRINT_SPEED = 8
const GRAVITY = 30
const DASH_SPEED = 25
var player_direction = Vector2(0.0, 1.0) # The direction in which the player last moved (stays the same when the player stands still)
const DIRECTION_CHANGE_DELAY := 0.0625 # The delay between when the player moves from a diagonal to a straight direction, 
										# and when the player_direction changes with it. 
										# This makes it easier for the player to have a diagonal player direction when standing still.
var direction_change_timer := 0.0 # The timer that counts when player_direction can move from a diagonal to an adjacent straight direction.
var dash_direction: Vector2
var is_dashing: bool = false
var downwards_velocity: float = 0.0

@onready var dash_timer = $"DashTimer"
@onready var staff = $Staff
@onready var animation = $AnimatedSprite3D
@onready var spell_input = $spell_input

func _ready():
	$AnimatedSprite3D.set_animation("player_walk_animation")

func _process(_delta):
	movement(_delta)
	animate()
	point_wand()
	Global.player_pos = global_position
	
func movement(_delta):
	'''gets player input and converts it to physics velocity'''
	var dir = Input.get_vector("Forward", "Backward", "Left", "Right")
	assess_player_direction(dir, _delta)
	do_gravity(_delta)
	if is_dashing:
		velocity = Vector3(dash_direction.y * DASH_SPEED, 0, dash_direction.x * DASH_SPEED)
	elif Input.is_action_pressed("Sprint"):
		velocity = Vector3(dir.y * SPRINT_SPEED, -downwards_velocity, dir.x * SPRINT_SPEED)
	else:
		velocity = Vector3(dir.y * MOVEMENT_SPEED, -downwards_velocity, dir.x * MOVEMENT_SPEED)
	move_and_slide()

func do_gravity(delta):
	if is_on_floor() or is_dashing:
		downwards_velocity = 0.0
	else:
		downwards_velocity += delta * GRAVITY

func assess_player_direction(direction: Vector2, delta: float) -> void:
	"""Assesses the player direction and changes the player_direction variable accordingly"""
	if not direction.is_zero_approx():
		if (direction_change_timer < DIRECTION_CHANGE_DELAY
			and 
			direction != player_direction): # Timer will only start counting down when the player changes direction.
			direction_change_timer += delta
			if (player_direction.dot(direction) < 0.5 # Angle between old and new directions more than 60 degrees.
				or 
				abs(player_direction.x) != abs(player_direction.y)): # Old direction not a diagonal.
				player_direction = direction
				direction_change_timer = 0.0
		else:
			player_direction = direction
			direction_change_timer = 0.0
	else:
		direction_change_timer = DIRECTION_CHANGE_DELAY

func dash(direction: Vector2) -> void:
	dash_timer.start()
	is_dashing = true
	dash_direction = direction

func _on_dash_timer_timeout():
	is_dashing = false

func animate():
	if velocity.x != 0 or velocity.z != 0:
		animation.play()
	else:
		animation.stop()
		animation.frame = 1
		
func point_wand():
	var direction = spell_input.spell_dir
	if direction.x < 0:
		staff.rotation = Vector3(30, 0, atan(direction.y / direction.x))
	if direction.x > 0:
		staff.rotation = Vector3(30, 0, atan(direction.y / direction.x) + 135)
		
	


func _on_dialogue_area_area_entered(area):
	'''method for changing the queued dialog in global var
	(this is in global as it needs to be accessed by a child of viewport)'''


	if area.has_meta('Dialogue'):
		Dialogue.reset()
		Dialogue.curr_dialogue = area.get_meta('Dialogue')
	if area.has_meta('DialogueSprite'):
		Dialogue.curr_dialogue_sprite = area.get_meta('DialogueSprite')
		
	if "unlocked" in area:
		if not area.unlocked:
			print('locked')
			if Global.key_amount > 0:
				print('unlocked')
				print(Global.key_amount)
				area.unlocked = true
				Global.key_amount -= 1
				
			

func _on_dialogue_area_area_exited(area):
	if area.has_meta('Dialogue'):
		Dialogue.curr_dialogue = null
		Dialogue.curr_dialogue_sprite = null
