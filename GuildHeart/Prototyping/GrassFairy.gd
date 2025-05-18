extends PointLight2D

func _process(delta: float) -> void:
	position.x += 0.1
	position.y += sin(position.x * 0.2) * 0.2
	
