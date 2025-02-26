extends CharacterBody2D

@onready var timer: Timer = $"../Fruits/Timer"
@onready var powerup_timer: Timer = $"Powerup Timer"
@onready var fruit_powerup_timer: Timer = $"Fruit Powerup Timer"
@onready var blender_area_2d: Area2D = $"blender area 2d"
@onready var combo_timer: Timer = $"Combo Timer"
@onready var main_menu_theme: AudioStreamPlayer = $"Main Menu Theme"


const SPEED = 275
const JUMP_VELOCITY = -300
const JUMP_HOLD_FORCE = -10
const JUMP_HOLD_TIME = 0.6

var is_jumping = false
var jump_timer = 0.1
var jump_stored = false
var menu_theme_play = false


func _ready() -> void:
	pass
	
func jump(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if Input.is_action_just_pressed("Jump"):
			jump_stored = true
		
	if Input.is_action_just_pressed("Jump") and is_on_floor() or jump_stored == true and is_on_floor():
		velocity.y = Global.JUMP_VELOCITY
		is_jumping = true
		jump_timer = JUMP_HOLD_TIME
		
	if Input.is_action_pressed("Jump") and is_jumping == true:
		jump_stored = true
		if jump_timer > 0:
			velocity.y += JUMP_HOLD_FORCE
			jump_timer -= delta
		else:
			is_jumping = false
			velocity = Vector2(0,-50)
			
	if Input.is_action_just_released("Jump"):
		is_jumping = false
		jump_stored = false

func _physics_process(delta):

	if Global.gamestart == true or Global.tutorial == true:
		show()
		main_menu_theme.stop() 
		var direction := Input.get_axis("Left", "Right")
	
		if Input.is_action_just_pressed("Escape"):
			get_tree().quit()
		
		if Global.speed_multiplier == 1.5 and Global.powerup_timer_started == false:
			powerup_timer.stop()
			powerup_timer.start()
			Global.powerup_timer_started = true
			
		if Global.fruit_x2_powerup_timer_started == true and Global.fruit_timer_start == false:
			fruit_powerup_timer.stop()
			fruit_powerup_timer.start()
			Global.fruit_timer_start = true
		
		if combo_timer.time_left == 0:
			combo_timer.start(5)
		
		if Global.comboed == true:
			combo_timer.start(5)
		
		jump(delta)
	
		if direction:
			velocity.x = direction * (SPEED * Global.speed_multiplier)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if global_position.y >= 1080:
			global_position = Vector2(556, 184)
			velocity.y = 0
			if Global.player_fruits >= 1:
				Global.player_fruits -= Global.fruit_drop
				print("You Fell and Dropped ", Global.fruit_drop, " Fruits!")
			else:
				Global.player_fruits = 0
				print("You Fell and Dropped your Ego :(")
	
		move_and_slide()
		Global.player_y = global_position.y
		Global.player_x = global_position.x
	
	elif Global.gamestart == false and main_menu_theme.playing == false and menu_theme_play == false:
		main_menu_theme.play()
		menu_theme_play = false
	
	else:
		hide()
		

func _on_powerup_timer_timeout() -> void:
	Global.speed_multiplier = 1
	Global.JUMP_VELOCITY = -300
	Global.powerup_timer_started = false

func on_area_2d_body_entered(body: Node2D) -> void:
	print("Bag Emptied!")
	Global.fruits_emptied += Global.player_fruits
	Global.player_score += (Global.player_fruits * 10)
	Global.player_fruits = 0


func _on_fruit_powerup_timer_timeout() -> void:
	Global.fruit_x2_powerup_timer_started = false
	Global.powerup_fruit_delete = true
	Global.fruit_timer_start = false


func _on_combo_timer_timeout() -> void:
	Global.comboed_timeout = true
