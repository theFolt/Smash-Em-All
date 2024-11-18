extends CharacterBody2D

@onready var animated_sprite=$AnimatedSprite2D

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	animated_sprite.play("blink")
	$Timer.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation_finished:
		animated_sprite.play("idle")
