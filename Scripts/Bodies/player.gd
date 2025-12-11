extends CharacterBody2D

@export var speed: float = 200.0
@export var camera_battery: float = 100.0  # Battery for camera
@export var battery_drain_rate: float = 10.0  # Battery drains per second

var has_camera: bool = false
var camera_active: bool = false

@onready var sprite = $Sprite2D
@onready var camera_view = $CameraView  # We'll create this next

func _ready():
	if camera_view:
		camera_view.visible = false

func _process(delta):
	# Camera toggle
	if has_camera and Input.is_action_just_pressed("toggle_camera"):
		camera_active = !camera_active
		toggle_camera_view()
	
	# Drain battery while camera is active
	if camera_active:
		camera_battery -= battery_drain_rate * delta
		if camera_battery <= 0:
			camera_battery = 0
			camera_active = false
			toggle_camera_view()
	
	# Display battery (for debugging)
	if camera_active:
		print("Battery: ", camera_battery)

func _physics_process(delta):
	# Top-down movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	move_and_slide()

func toggle_camera_view():
	if camera_active:
		# Show first-person camera view
		sprite.visible = false
		if camera_view:
			camera_view.visible = true
	else:
		# Show top-down view
		sprite.visible = true
		if camera_view:
			camera_view.visible = false

func pickup_camera():
	has_camera = true
	print("Camera picked up!")
