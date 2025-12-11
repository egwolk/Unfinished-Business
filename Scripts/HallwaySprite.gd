extends Sprite2D

func _process(delta):
	if visible:
		scale.x = lerp(scale.x, 1.2, delta * 2.0)
		scale.y = lerp(scale.y, 1.2, delta * 2.0)
