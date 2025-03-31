extends Node2D

var fruits_scene = preload("res://fruits/fruits.tscn")
var fruit_spawn_timer : Timer
var timer_started = false

func _ready() -> void:
	_instantiate()
	fruit_spawn_timer = Timer.new()
	add_child(fruit_spawn_timer)
	fruit_spawn_timer.timeout.connect(_on_fruit_timeout)
	fruit_spawn_timer.start(Global.fruit_x2_time)
	timer_started = true

func _process(delta: float) -> void:
		
	if Global.gameover == true:
		fruit_spawn_timer.stop()
		timer_started = false
		if get_tree().get_nodes_in_group("fruits").size() > 0: #check for how many fruits are on screen
			get_tree().get_nodes_in_group("fruits").front().queue_free()
			
	elif Global.gamestart == true and timer_started == false:
		fruit_spawn_timer.start(Global.fruit_x2_time)
		timer_started = true
		print("spawned")

func _instantiate():
	var fruit_instance = fruits_scene.instantiate()
	add_child(fruit_instance)
	fruit_instance.global_position = Vector2(randi_range(-100, 1500), 0)
	fruit_instance.linear_velocity = Vector2(randi_range(-100, 100), randi_range(50, 0))
	fruit_instance.show()
	fruit_instance.add_to_group("fruits")
			
func _on_fruit_timeout():
	print("fruit_spawned")
	_instantiate()
	timer_started = false
