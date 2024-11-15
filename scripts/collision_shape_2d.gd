extends AnimatedSprite2D

func _on_body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:  # Left mouse button
			print("Left click detected on character body!")
