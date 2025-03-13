extends RigidBody2D

class_name fruit

var fruit_scene = preload("res://fruits/fruits.tscn")
var fruits_collected = 0
var time_on_ground = 3
var rarity = 0
var started = false
var speed_power = false
var fruit_x2 = false
var spawn_timer = Timer.new()
var timer_started = false

@onready var area_2d: Area2D = $Area2D
@onready var fruit_2d: Sprite2D = $Fruit2D
@onready var powerup_timer: Timer = $"Powerup Timer"
@onready var fruit_powerup_timer: Timer = $"Fruit Powerup Timer"

signal fruit_collide

func _ready() -> void:
	spawn_timer.timeout.connect(on_spawn_timer_timeout)

func _on_area_2d_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		if Global.player_fruits <= Global.basket_size:
			if speed_power == true:
				print("powerup")
				speed_powerup()
				emit_signal("speed_power")
				speed_power = false
			if fruit_x2 == true and Global.fruit_x2_powerup_timer_started == false:
				for fruits in get_tree().get_nodes_in_group("fruits").size():
					duplicate_fruit()
				Global.fruit_x2_powerup_timer_started = true
				Global.fruit_timer_start = false
				fruit_x2 = false
			emit_signal("fruit_collide")
			Global.comboed = true
			print("player collided w fruit")
			duplicate_fruit()
			Global.player_fruits += 1
			queue_free() 
		else:
			print("empty ur bag and stop being greedy")
	
	elif body is TileMapLayer and  timer_started == false:
				spawn_timer.start(4)
				print("started")
				timer_started = true

func duplicate_fruit():
		var instance  = load("res://fruits/fruits.tscn")
		var new_fruit = instance.instantiate()
		get_parent().add_child(new_fruit)
		new_fruit.global_position = Vector2(randi_range(40, 1500), 40)
		new_fruit.linear_velocity = Vector2(randi_range(-100, 100), randi_range(50, 0))
		new_fruit.add_to_group("fruits")
		if get_tree().get_nodes_in_group("fruits").size() > 2: #check for how many fruits are on screen
			queue_free()

func _process(delta: float) -> void:
	print(spawn_timer.time_left)
	if global_position.y > 1065:
		duplicate_fruit()
		queue_free()
	if Global.gamestart == true and started == true:
		duplicate_fruit()
		queue_free()
	if Global.powerup_fruit_delete == true:
			if get_tree().get_nodes_in_group("fruits").size() >= 2:
				queue_free()
			Global.powerup_fruit_delete = false
	if Global.gameover == true:
		if get_tree().get_nodes_in_group("fruits").size() >= 1:
				queue_free()

func on_spawn_timer_timeout():
	duplicate_fruit()
	queue_free()
	timer_started = false

func speed_powerup():
	Global.speed_multiplier = 1.5
	Global.JUMP_VELOCITY = -385
	Global.powerup_timer_started = false
	
