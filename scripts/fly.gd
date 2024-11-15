extends CharacterBody2D

@export var speed: float = 70
@onready var animated_sprite=$AnimatedSprite2D
var rng = RandomNumberGenerator.new()
var goTo = Vector2(snapped(rng.randf_range(-100.0, 100.0),0),snapped(rng.randf_range(-100.0, 100.0),0))

func _process(delta: float) -> void:
	if (snapped(global_position.x,0) == goTo.x or snapped(global_position.x,0) == goTo.x-1 or snapped(global_position.x,0) == goTo.x+1):
		goTo = Vector2(snapped(rng.randf_range(-100.0, 100.0),0),snapped(rng.randf_range(-100.0, 100.0),0))
	else:
		velocity = position.direction_to(goTo) * speed
	move_and_slide()


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		animated_sprite.play("angry")
		speed = 140
