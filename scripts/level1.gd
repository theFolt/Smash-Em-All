extends Node2D

var fly=load("res://scenes/fly.tscn")
var bee=load("res://scenes/bee.tscn")
var mosquito=load("res://scenes/mosquito.tscn")



var rng = RandomNumberGenerator.new()
var do_it_once= 1
var score:int = 0

func _ready() -> void:
	if is_instance_valid($firstSpawn):
		$firstSpawn.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid($steve/HealthBar):
		if $steve/HealthBar.value <= 0 and do_it_once == 1:
			get_tree().change_scene_to_file("res://scenes/endScreen.tscn")
			#$nextWave.stop()
			#if $fly.is_inside_tree():
				#$fly.queue_free()
			#if $bee.is_inside_tree():
				#$bee.queue_free()
			#if $mosquito.is_inside_tree():
				#$mosquito.queue_free()
			#disp_score($steve/HealthBar.value)
			do_it_once = 0

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
	
#func score_couter(bug, points:int) -> void:
	#score+=points
	
#func disp_score(x) -> void:
	##if x == 0:
		##score+=1000
		##score+=x
	##var endScreen=load("res://scenes/endScreen.tscn").instantiate()
	##endScreen.position = Vector2(0.0,0.0)
	##add_child(endScreen)
	#print(x, score)
#
#func return_score() -> int:
	#return(score)
