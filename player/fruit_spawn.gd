extends Node2D

var fruits_scene = preload("res://fruits/fruits.tscn")
var fruit_spawn_timer : Timer

func _ready() -> void:
	_instantiate()
	fruit_spawn_timer = Timer.new()
	add_child(fruit_spawn_timer)
	fruit_spawn_timer.timeout.connect(_on_fruit_timeout)
	fruit_spawn_timer.start(Global.fruit_x2_time)

func _process(delta: float) -> void:
	if Global.gameover == true:
		fruit_spawn_timer.stop()
		if get_tree().get_nodes_in_group("fruits").size() > 0: #check for how many fruits are on screen
			get_tree().get_nodes_in_group("fruits").front().queue_free()
		

func _instantiate():
	var fruit_instance = fruits_scene.instantiate()
	add_child(fruit_instance)
	fruit_instance.global_position = Vector2(randi_range(-100, 1500), 40)
	fruit_instance.linear_velocity = Vector2(randi_range(-100, 100), randi_range(50, 0))
	fruit_instance.show()
	fruit_instance.add_to_group("fruits")
			
func _on_fruit_timeout():
	print("fruit_timeout")
	_instantiate()
	fruit_spawn_timer.start(Global.fruit_x2_time)


func _on_new_fruit():
	print("new_fruit")
	_instantiate()
