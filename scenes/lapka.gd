extends Node2D
var animation_player: AnimatedSprite2D
var animation_played: bool = false
var time_since_start: float = 0.0
var animation_duration: float = 0.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player = $AnimatedSprite2D


func _process(delta):
	position = get_viewport().get_mouse_position()
	if animation_played:
		time_since_start += delta
		if time_since_start >= animation_duration:
			animation_player.stop()
			animation_player.play("idle")	
			animation_played = false


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not animation_played:
			animation_player.play("pac")
			animation_played = true
			time_since_start = 0.0
