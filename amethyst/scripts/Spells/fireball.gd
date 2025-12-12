extends Node3D

const DESPAWN_TIME = 1.0
var despawn_timer = 0.0
const MOVEMENT_SPEED = 9
var direction: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate_y(Vector2(-1.0, 0.0).angle_to(direction))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	despawn_timer += delta
	position.x += direction.y * MOVEMENT_SPEED * delta
	position.z += direction.x * MOVEMENT_SPEED * delta
	if despawn_timer >= DESPAWN_TIME:
		queue_free()


func _on_fireball_object_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		if body.has_method("take_damage"):
			body.take_damage('Fireball', direction)		
		queue_free()
