extends CharacterBody2D

var MAX_HEALTH = 100
var health = MAX_HEALTH
@onready var animated_sprite=$AnimatedSprite2D

func _ready() -> void:
	set_HealthBar()
	$HealthBar.max_value=MAX_HEALTH
	$blinkTimer.start()
	
func set_HealthBar() -> void:
	$HealthBar.value = health
	
func damage(a) -> void:
	health -= a
	if health < 0:
		print("Steve died")
	set_HealthBar()
	 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("fly"):
		print("got bit by a fly")
		damage(2)
	if area.is_in_group("bee"):
		print("got bit by a bee")
		damage(2)
	if area.is_in_group("mosquito"):
		print("got bit by a mosquito")
		damage(2)


func _on_blink_timer_timeout() -> void:
	animated_sprite.play("blink")
	$blinkTimer.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation_finished:
		animated_sprite.play("idle")
