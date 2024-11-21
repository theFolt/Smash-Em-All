extends Node2D

var fly=load("res://scenes/fly.tscn")
var bee=load("res://scenes/bee.tscn")
var mosquito=load("res://scenes/mosquito.tscn")


var rng = RandomNumberGenerator.new()
var do_it_once:int = 1
@onready var score:int = 0
var wave_couter:int = 0
var enemies_cout:int = 0

func _ready() -> void:
	if is_instance_valid($firstSpawn):
		$firstSpawn.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if is_instance_valid($endScreen):
		$endScreen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid($steve):
		if $steve/HealthBar.value <= 0 and do_it_once == 1:
			$nextWave.stop()
			#if $fly.is_inside_tree():
				#$fly.queue_free()
			#if $bee.is_inside_tree():
				#$bee.queue_free()
			#if $mosquito.is_inside_tree():
				#$mosquito.queue_free()
			$endScreen.visible = true
			print(ScoreManager.score)
			$endScreen/scoreDisp.text = str(ScoreManager.score)
			do_it_once = 0
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$lapka.visible = false
		if wave_couter > 8 and enemies_cout == -39:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#if wave_couter > 8 and $bee.is_inside_tree() == false and $mosquito.is_inside_tree() == false and $fly.is_inside_tree() == false:
			ScoreManager.score+=1000
			$lapka.visible = false
			ScoreManager.score+=$steve/HealthBar.value
			$endScreen.visible = true
			$endScreen/scoreDisp.text = str(ScoreManager.score)

	
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

func basic_wave() ->  void:
	var fly = fly.instantiate()
	fly.position = drawSpawnPosition()
	add_child(fly)
	var bee = bee.instantiate()
	bee.position = drawSpawnPosition()
	add_child(bee)
	var mosquito = mosquito.instantiate()
	mosquito.position = drawSpawnPosition()
	add_child(mosquito)
	
func fly_wave() -> void:
	for x in range(0,3):
		var fly = fly.instantiate()
		fly.position = drawSpawnPosition()
		add_child(fly)

func bee_wave() -> void:
	for x in range(0,3):
		var bee = bee.instantiate()
		bee.position = drawSpawnPosition()
		add_child(bee)
		
func mosquito_wave() -> void:
	for x in range(0,3):
		var mosquito = mosquito.instantiate()
		mosquito.position = drawSpawnPosition()
		add_child(mosquito)

func final_wave() -> void:
	for x in range(0,3):
		var fly = fly.instantiate()
		fly.position = drawSpawnPosition()
		add_child(fly)
		var bee = bee.instantiate()
		bee.position = drawSpawnPosition()
		add_child(bee)
		var mosquito = mosquito.instantiate()
		mosquito.position = drawSpawnPosition()
		add_child(mosquito)
		
	
	
func drawNextWave() -> void:
	var wave=rng.randi_range(1,3)
	if wave == 1:
		fly_wave()
	elif wave == 2:
		bee_wave()
	else:
		mosquito_wave()

func _on_next_wave_timeout() -> void:
	if wave_couter == 0:
		basic_wave()
	elif wave_couter == 1:
		fly_wave()
	elif wave_couter == 2:
		bee_wave()
	elif wave_couter == 3:
		mosquito_wave()
	elif wave_couter == 4:
		drawNextWave()
	elif wave_couter == 5:
		drawNextWave()
	elif wave_couter == 6:
		drawNextWave()
		drawNextWave()
	elif wave_couter == 7:
		drawNextWave()
		drawNextWave()
	else:
		final_wave()
		
	wave_couter+=1
	
#func score_couter(bug, points:int) -> void:
	#score+=points
	#print(score)
