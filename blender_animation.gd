extends AnimatedSprite2D

@onready var blender_area_2d: Area2D = $"blender area 2d"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Global.gamestart == true:
		show()
		blender_area_2d.show()
		blender_area_2d.global_position = global_position
		
		if Global.blender_started == true:
			play("default")
		elif Global.blender_started == false:
			stop()
		
		if Global.level == 1:
			global_position = Vector2(960, 885) 
		if Global.level == 2:
			global_position = Vector2(1875, 837)
		if Global.gameover == true:
			hide()
			blender_area_2d.hide()
	else:
		hide()
