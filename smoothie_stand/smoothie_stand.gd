extends Sprite2D

@onready var smoothie_stand_area_2d: Area2D = $smoothie_stand_area_2d

func _process(delta: float) -> void:
	if Global.gamestart == true:
		show()
		smoothie_stand_area_2d.show()
		smoothie_stand_area_2d.global_position = global_position
		if Global.level == 0:
			global_position = Vector2(1856, 859) 
		if Global.level == 1:
			global_position = Vector2(96, 811)
		if Global.level == 2:
			global_position = Vector2(96, 872)
		if Global.level == 3:
			global_position = Vector2(64, 859)
			
		if Global.gameover == true:
			hide()
			smoothie_stand_area_2d.hide()
	else:
		hide()
