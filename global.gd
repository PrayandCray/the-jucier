extends Node

var JUMP_VELOCITY = -300
var endless = false
var player_fruits = 0
var player_y = 0
var player_x = 0
var player_score = 0
var basket_size = 4
var smoothies = 0
var smoothie_limit = 2
var fruits_emptied = 0
var fruit_drop = 1
var fruit_x2_time = 2.5
var fruit_sfx_pitch_scale = 0
var customer_count = 15
var sold_smoothies = 0
var level = 0
var gamestart = false
var menuing = true
var level_select = false
var spawned = false
var fruit_dead = false
var customers_served = 0
var speed_multiplier = 1
var powerup_timer_started = false
var fruit_x2_powerup_timer_started = false
var powerup_fruit_delete = false
var comboed = false
var combo_restart = false
var comboed_timeout = false
var fruit_timer_start = false
var new_fruit = false
var blender_show = false
var fruit_delete = false
var blender_started = false
var tutorial = false
var gameover = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if gamestart == false:
		var JUMP_VELOCITY = -300
		var player_fruits = 0
		var player_y = 0
		var player_x = 0
		var player_score = 0
		var basket_size = 4
		var smoothies = 0
		var smoothie_limit = 2
		var fruits_emptied = 0
		var fruit_drop = 1
		var fruit_x2_time = 2.5
		var fruit_sfx_pitch_scale = 0
		var customer_count = 15
		var sold_smoothies = 0
		var level = 1
