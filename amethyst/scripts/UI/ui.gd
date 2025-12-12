extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("health_change", update_health_text)
	update_health_text()

func update_health_text():
	health_bar.value = Global.player_health
