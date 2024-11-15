extends CharacterBody2D

@export var speed: float = 100.0

func _process(delta: float) -> void:
	if (global_position != get_global_mouse_position()):
		var mouse_position: Vector2 = get_global_mouse_position()
	
		var direction: Vector2 = (mouse_position - global_position).normalized()
	
		velocity = direction * speed
	
		move_and_slide()
#var speed = 200

#func _physics_process(delta):
#	var velocity = Vector2()

#	if Input.is_action_pressed('ui_right'):
#		velocity.x += 1

#	if Input.is_action_pressed('ui_left'):
#		velocity.x -= 1
		
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1

#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1

#	velocity = velocity.normalized() * speed
#	move_and_collide(velocity * delta)
