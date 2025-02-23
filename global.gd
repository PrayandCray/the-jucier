extends Node

@onready var powerup_timer: Timer = $"Powerup Timer"

var JUMP_VELOCITY = -300
var endless = false
var player_fruits = 0
var player_score = 0
var basket_size = 4 #bcs python always starts from 0 remember that lil bro
var fruits_emptied = 0
var fruit_drop = 1
var level = 1
var gamestart = false
var speed_multiplier = 1
var powerup_timer_started = false
var fruit_x2_powerup_timer_started = false
var powerup_fruit_delete = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
