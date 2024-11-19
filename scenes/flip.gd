extends AnimatedSprite2D

#func _process(delta: float) -> void:
	#if Fly.goTo.x > Fly.global_position.x:
		#$AnimatedSprite2D.flip_h = true
	#elif Fly.goTo.x < Fly.global_position.x:
		#$AnimatedSprite2D.flip_h = false
