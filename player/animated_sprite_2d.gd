extends AnimatedSprite2D

var right = true
var left = false
var ground_touch = false

func _physics_process(delta: float) -> void:
	if Global.gamestart == true or Global.tutorial == true:
		
		if Input.is_action_pressed("Left"):
			left = true
			right = false
			
		if Input.is_action_pressed("Right"):
			right = true
			left = false
			
		if get_parent().is_on_floor():
			if Input.is_anything_pressed() == true:
				if Input.is_action_pressed("Left") and left == true:
					play("left run")
				
				if Input.is_action_just_released("Left") and left == true:
					stop()
					
				if Input.is_action_pressed("Right") and right == true:
					play("right run")
					
				if Input.is_action_just_released("Right") and right == true:
					stop()
			
			else:
				if right == true:
					play("right idle")
				if left == true:
					play("left idle")
					
		if get_parent().is_on_floor() == false:
			if left == true and get_parent().velocity.y < 0:
				play("left jump")
			if right == true and get_parent().velocity.y < 0:
				play("right jump")
				
			if right == true and get_parent().velocity.y > 0:
				play("right fall")
			if left == true and get_parent().velocity.y > 0:
				play("left fall")
