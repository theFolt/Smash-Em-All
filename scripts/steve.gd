extends CharacterBody2D

var MAX_HEALTH = 100
var health = MAX_HEALTH

func _ready() -> void:
	$HealthBar.max_value=MAX_HEALTH
	$blinkTimer.start()

func damage(a) -> void:
	health -= a
	if health < 0:
		print("Steve died")
	$HealthBar.value = health
	 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("fly"):
		print("got bit by a fly")
		damage(Fly.damage)
	if area.is_in_group("bee"):
		print("got bit by a bee")
		damage(Bee.damage)
	if area.is_in_group("mosquito"):
		print("got bit by a mosquito")
		damage(Mosquito.damage)


func _on_blink_timer_timeout() -> void:
	$AnimatedSprite2D.play("blink")
	$blinkTimer.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation_finished:
		$AnimatedSprite2D.play("idle")
