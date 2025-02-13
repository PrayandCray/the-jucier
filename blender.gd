extends Sprite2D

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Global.gamestart == true:
		show()
		if Global.level == 1:
			global_position = Vector2(960, 871)
		if Global.level == 2:
			global_position = Vector2(1872, 824)
	else:
		hide()
