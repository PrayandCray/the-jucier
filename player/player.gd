extends CharacterBody2D

@onready var timer: Timer = $"../Fruits/Timer"

const SPEED = 275
const JUMP_VELOCITY = -300
const JUMP_HOLD_FORCE = -10
const JUMP_HOLD_TIME = 0.6

var is_jumping = false
var jump_timer = 0.1
var jump_stored = false

func jump(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if Input.is_action_just_pressed("ui_up"):
			jump_stored = true
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor() or jump_stored == true and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_timer = JUMP_HOLD_TIME
		
	if Input.is_action_pressed("ui_up") and is_jumping == true:
		jump_stored = true
		if jump_timer > 0:
			velocity.y += JUMP_HOLD_FORCE
			jump_timer -= delta
		else:
			is_jumping = false
			velocity = Vector2(0,-50)
			
	if Input.is_action_just_released("ui_up"):
		is_jumping = false
		jump_stored = false

func _physics_process(delta):
	if Global.gamestart == true:
		show()
		var direction := Input.get_axis("ui_left", "ui_right")
	
		if Input.is_action_just_pressed("Escape"):
			get_tree().quit()
	
		jump(delta)
	
		if direction:
			velocity.x = direction * SPEED
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
	else:
		hide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Bag Emptied!")
	Global.fruits_emptied += Global.player_fruits
	Global.player_score += (Global.player_fruits * 10)
	Global.player_fruits = 0
	
