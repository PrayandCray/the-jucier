extends Node2D

@onready var _1: TileMapLayer = $"1"
@onready var _2: TileMapLayer = $"2"

func _process(delta: float) -> void:
	if Global.gamestart == true:
		_1.collision_enabled = true
		_2.collision_enabled = false
		_2.hide()
		show()
		if Global.player_score >= 250:
			if Global.level == 1:
				Global.level += 1
				_1.hide()
				_1.collision_enabled = false
				_2.show()
				_2.collision_enabled = true
	else: 
		hide()
		_1.collision_enabled = false
		_2.collision_enabled = false
