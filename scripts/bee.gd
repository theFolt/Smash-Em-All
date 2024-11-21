extends CharacterBody2D


var speed: float = 70
@onready var animated_sprite=$AnimatedSprite2D
var health = 3
var damage = 2
var is_in_lapka_area=0

#create first cords to go to
#snapped rounds the random number to intigers
var rng = RandomNumberGenerator.new()
var goTo = Vector2(snapped(rng.randf_range(-224.0, 224.0),0),snapped(rng.randf_range(-119.0, 119.0),0))


	
func _process(delta: float) -> void:
	
	#random movement
	#there is so room for error so the movement is less buggy when reaching the destination
	if (snapped(global_position.x,0) == goTo.x or snapped(global_position.x,0) == goTo.x-1 or snapped(global_position.x,0) == goTo.x+1):
		goTo = Vector2(snapped(rng.randf_range(-224.0, 224.0),0),snapped(rng.randf_range(-119.0, 119.0),0))
		
		#test
		#goTo= Vector2(220.0,135.0)
	else:
		velocity = position.direction_to(goTo) * speed
	move_and_slide()
	
	
	#flip the sprite while moveing
	if is_instance_valid(animated_sprite):
		if goTo.x > global_position.x:
			animated_sprite.flip_h = true
		elif goTo.x < global_position.x:
			animated_sprite.flip_h = false


func _input_event(viewport, event, shape_idx):
	#action when clicked on Collision Shape
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_in_lapka_area==1:
		health -= 1
		$HealthBar.value = health
		if health == 1:
			animated_sprite.play("angry")
			damage = 4
			speed = 140

		if health == 0:
			queue_free()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R:
			animated_sprite.play("normal")
			damage = 2
			speed = 70

func drawNewPositionOnCollison() -> void:
	var area=rng.randi_range(1,4)
	if area==1:
		goTo = Vector2(-230.0,snapped(rng.randf_range(-115.0, 115.0),0))
	elif area==2:
		goTo = Vector2(snapped(rng.randf_range(-230.0, 230.0),0),-115.0)
	else:
		goTo = Vector2(230.0,snapped(rng.randf_range(-115.0, 115.0),0))

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("steve"):
		drawNewPositionOnCollison()
	if area.is_in_group('lapka'):
		is_in_lapka_area=1


func _on_area_2d_area_exited(area: Area2D) -> void:
		if area.is_in_group('lapka'):
			is_in_lapka_area=0
