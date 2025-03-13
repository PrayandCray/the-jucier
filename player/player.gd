extends CharacterBody2D

@onready var powerup_timer: Timer = $"Powerup Timer"
@onready var fruit_powerup_timer: Timer = $"Fruit Powerup Timer"
@onready var combo_timer: Timer = $"Combo Timer"
@onready var main_menu_theme: AudioStreamPlayer = $"Main Menu Theme"
@onready var in_game_song: AudioStreamPlayer = $"In-Game Song"
@onready var awakening_speck: AudioStreamPlayer = $"Awakening - Speck"
@onready var fruit_dead_sfx: AudioStreamPlayer = $fruit_dead_sfx
@onready var blender_area_2d: Area2D = $"../Blender Animation/blender area 2d"

const SPEED = 275
const JUMP_VELOCITY = -300
const JUMP_HOLD_FORCE = -10
const JUMP_HOLD_TIME = 0.6

var is_jumping = false
var jump_timer = 0.1
var jump_stored = false
var music_playing = false

func _ready() -> void:
	blender_area_2d.body_entered.connect(on_area_2d_body_entered)

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
	
	if is_on_ceiling():
		is_jumping = false
			
	if Input.is_action_just_released("Jump"):
		is_jumping = false
		jump_stored = false

func _physics_process(delta):

	if Global.gamestart == true or Global.tutorial == true:
		show()
		main_menu_theme.stop()
		if music_playing == false and in_game_song.playing == false and main_menu_theme.playing == false:
			in_game_song.play()
			music_playing = true
		if in_game_song.playing == false:
			music_playing = false
			
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
		
		if Global.fruit_dead == true:
			fruit_dead_sfx.pitch_scale += Global.fruit_sfx_pitch_scale
			fruit_dead_sfx.play()
			Global.fruit_dead = false
		
		if Global.gameover == true:
			in_game_song.stop()
			hide()
			if in_game_song.playing == false and awakening_speck.playing == false:
				awakening_speck.play()

		if Global.fruits_emptied >= 5:
			Global.fruits_emptied -= 5
			Global.blender_started = true

		move_and_slide()
		Global.player_y = global_position.y
		Global.player_x = global_position.x
	
	elif Global.gamestart == false and main_menu_theme.playing == false and music_playing == false:
		main_menu_theme.play()
		music_playing = false
	
	else:
		hide()
		
		
func _on_powerup_timer_timeout() -> void:
	Global.speed_multiplier = 1
	Global.JUMP_VELOCITY = -300
	Global.powerup_timer_started = false

func on_area_2d_body_entered(body: Node2D) -> void:
	if Global.smoothies <= Global.smoothie_limit - 1 and Global.blender_started == false:
		print("Bag Emptied!")
		Global.fruits_emptied += Global.player_fruits
		Global.player_score += (Global.player_fruits * 5)
		Global.player_fruits = 0
	
func _on_fruit_powerup_timer_timeout() -> void:
	Global.fruit_x2_powerup_timer_started = false
	Global.fruit_x2_time = 2.5
	Global.fruit_timer_start = false

func _on_combo_timer_timeout() -> void:
	fruit_dead_sfx.pitch_scale = 1
	Global.comboed_timeout = true

func _on_smoothie_stand_area_2d_body_entered(body: Node2D) -> void:
	for smoothies in range(Global.smoothies):
		Global.sold_smoothies += 1
	print("sold ", str(Global.smoothies), " smoothies")
	Global.player_score += (Global.smoothies * 40)
	Global.smoothies = 0
