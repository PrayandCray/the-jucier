extends AnimatedSprite2D

@onready var blender_area_2d: Area2D = $"blender area 2d"

var pos_set = false

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Global.gamestart == true:
		show()
		blender_area_2d.show()
		blender_area_2d.global_position = global_position
		
		if Global.blender_started == true:
			if pos_set == false:
				global_position.y -= 8
				play("default")
				pos_set = true
				
		elif Global.blender_started == false:
			stop()
			pos_set = false
			if Global.level == 0:
				global_position = Vector2(960, 893)
			if Global.level == 1:
				global_position = Vector2(1875, 843)
				
		if Global.gameover == true:
			hide()
			blender_area_2d.hide()
			
	if Global.tutorial == true:
		if Global.blender_show == false:
			hide()
		elif Global.blender_show == true:
			show()
			
	if Global.gamestart == false and Global.tutorial == false:
		hide()
	
	if Global.menuing == true:
		stop()
		play("Empty")
		Global.blender_started = false
		hide()
