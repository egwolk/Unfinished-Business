extends CanvasLayer

@onready var battery_label = $Control/BatteryLabel
var player = null

func _ready():
	player = get_parent()  # Reference to Player node

func _process(delta):
	if visible and player:
		battery_label.text = "BATTERY: %.1f%%" % player.camera_battery
