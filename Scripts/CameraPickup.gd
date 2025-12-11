extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.has_method("pickup_camera"):
		body.pickup_camera()
		queue_free()
