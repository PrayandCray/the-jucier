extends RigidBody2D

signal fruit_collide
var fruit_scene = preload("res://fruits/fruits.tscn")
var fruits_collected = 0
var time_on_ground = 3
var rarity = 0
var started = false

@onready var area_2d: Area2D = $Area2D
@onready var fruit: Sprite2D = $Fruit
@onready var spawn_timer: Timer = $Spawn_Timer

var common_fruit_sprites = [
	load("res://Pixel Adventure 1/Free/Main Characters/Mask Dude/Jump (32x32).png"),
	load("res://Pixel Adventure 1/Free/Main Characters/Pink Man/Jump (32x32).png"),
	load("res://Pixel Adventure 1/Free/Main Characters/Virtual Guy/Jump (32x32).png"),
]

var rare_fruit_sprites = [
	load("res://Pixel Adventure 1/Free/Traps/Rock Head/Idle.png"),
	load("res://Pixel Adventure 1/Free/Traps/Spike Head/Idle.png"),
	load("res://Pixel Adventure 1/Free/Traps/Trampoline/Idle.png")
]


func _ready():
		start_timer(4)
		if Global.gamestart == true:
			spawn_timer.start(3)
		else:
			spawn_timer.start(2)
		rarity = randi_range(1, 10)
		if rarity <= 6:
			fruit.texture = common_fruit_sprites.pick_random()
		if rarity > 6:
			fruit.texture = rare_fruit_sprites.pick_random()
		fruit.scale *= 5

func _on_area_2d_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		if Global.player_fruits <= Global.basket_size:
			emit_signal("fruit_collide")
			print("player collided w fruit")
			spawn_timer.stop()
			spawn_timer.start()
			duplicate_fruit()
			Global.player_fruits += 1
			print(Global.player_fruits)
			queue_free()
		else:
			print("empty ur bag and stop being greedy")

func duplicate_fruit():
		var instance  = load("res://fruits/fruits.tscn")
		var new_fruit = instance.instantiate()
		get_parent().add_child(new_fruit)
		new_fruit.global_position = Vector2(randi_range(40, 1870), 40)
		new_fruit.linear_velocity = Vector2(randi_range(-100, 100), randi_range(50, 0))
		new_fruit.add_to_group("fruits")
		print("fruit_spawned!")
		if get_tree().get_nodes_in_group("fruits").size() > 3: #check for how many fruits are on screen
			self.queue_free()

func _process(delta: float) -> void:
	if global_position.y > 2000:
		queue_free()

func start_timer(duration: float):
	var timer = get_tree().create_timer(duration)  # Creates a one-shot timer
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	print("timeout")
	duplicate_fruit()
	queue_free()


func _on_spawn_timer_timeout() -> void:
	duplicate_fruit()
