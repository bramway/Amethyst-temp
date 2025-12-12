extends Node

@onready var element_manager = $"../../ElementManager"
@onready var crystal_sprite = $ElementCrystal
@onready var element_particles = $GPUParticles2D
@onready var viewport = $"../.."

var atlas_map: Dictionary = {
	"light": Rect2(0, 0, 3, 3),
	"water": Rect2(3, 0, 3, 3),
	"fire": Rect2(6, 0, 3, 3),
	"earth": Rect2(0, 3, 3, 3),
	"darkness": Rect2(3, 3, 3, 3),
	"wind": Rect2(6, 3, 3, 3),
}


const RELATIVE_X_POSITION: float = 0.1
const RELATIVE_Y_POSITION: float = 0.8
const SCALE = 0.0008

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Fire") and element_manager.Element.FIRE in element_manager.unlocked_elements:
		crystal_sprite.frame = 3
		element_particles.texture.region = atlas_map["fire"]
	if Input.is_action_just_pressed("Water") and element_manager.Element.WATER in element_manager.unlocked_elements:
		crystal_sprite.frame = 5
		element_particles.texture.region = atlas_map["water"]
	if Input.is_action_just_pressed("Earth") and element_manager.Element.EARTH in element_manager.unlocked_elements:
		crystal_sprite.frame = 2
		element_particles.texture.region = atlas_map["earth"]
	if Input.is_action_just_pressed("Wind") and element_manager.Element.WIND in element_manager.unlocked_elements:
		crystal_sprite.frame = 6
		element_particles.texture.region = atlas_map["wind"]
	self.position = Vector2(viewport.size.x * RELATIVE_X_POSITION, viewport.size.y * RELATIVE_Y_POSITION)
	self.scale = Vector2(viewport.size.x * SCALE, viewport.size.x * SCALE)
