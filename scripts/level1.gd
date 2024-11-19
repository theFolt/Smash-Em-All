extends Node2D

var fly=load("res://scenes/fly.tscn")
var bee=load("res://scenes/bee.tscn")
var mosquito=load("res://scenes/mosquito.tscn")

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$firstSpawn.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/menu.tscn")

func drawSpawnPosition() -> Vector2:
	var area=rng.randi_range(1,3)
	if area==1:
		return Vector2(-230.0,snapped(rng.randf_range(-115.0, 115.0),0))
	elif area==2:
		return Vector2(snapped(rng.randf_range(-230.0, 230.0),0),-115.0)
	else:
		return Vector2(230.0,snapped(rng.randf_range(-115.0, 115.0),0))

func _on_first_spawn_timeout() -> void:
	var fly = fly.instantiate()
	fly.position = drawSpawnPosition()
	add_child(fly)
	var bee = bee.instantiate()
	bee.position = drawSpawnPosition()
	add_child(bee)
	var mosquito = mosquito.instantiate()
	mosquito.position = drawSpawnPosition()
	add_child(mosquito)
	$firstSpawn.stop()
	$nextWave.start()


func _on_next_wave_timeout() -> void:
	var fly = fly.instantiate()
	fly.position = drawSpawnPosition()
	add_child(fly)
	var bee = bee.instantiate()
	bee.position = drawSpawnPosition()
	add_child(bee)
	var mosquito = mosquito.instantiate()
	mosquito.position = drawSpawnPosition()
	add_child(mosquito)
