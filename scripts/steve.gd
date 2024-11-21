extends CharacterBody2D

var MAX_HEALTH = 5
var health = MAX_HEALTH
var is_alive = 1

func _ready() -> void:
	if is_instance_valid($HealthBar):
		$HealthBar.max_value=MAX_HEALTH
	if is_instance_valid($blinkTimer):
		$blinkTimer.start()

func damage(a) -> void:
	health -= a
	if health <= 0:
		print("Steve died")
		is_alive = 0
		print(is_alive)
		#get_tree().paused = true
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
