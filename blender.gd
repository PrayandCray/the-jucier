extends Sprite2D

@onready var area_2d: Area2D = $Area2D
@onready var blender_area_2d: Area2D = $"blender area 2d"


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Global.gamestart == true:
		show()
		blender_area_2d.show()
		blender_area_2d.global_position = global_position
		if Global.level == 1:
			global_position = Vector2(960, 871) 
		if Global.level == 2:
			global_position = Vector2(1872, 824)
	else:
		hide()
