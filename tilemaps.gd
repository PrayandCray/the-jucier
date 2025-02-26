extends Node2D

@onready var _1: TileMapLayer = $"1"
@onready var _2: TileMapLayer = $"2"


func _process(delta: float) -> void:
	if Global.gamestart == true:
		level_change()
		
	else: 
		_1.hide()
		_2.hide()
		_1.collision_enabled = false
		_2.collision_enabled = false
		
	if Global.tutorial == true:
		_1.show()
		_1.collision_enabled = true

func level_change():
	if Global.player_score >= 250:
		if Global.level == 1:
			_1.hide()
			_1.collision_enabled = false
			_2.show()
			_2.collision_enabled = true
			Global.level += 1
	else: 
		_1.collision_enabled = true
		_2.collision_enabled = false
		_2.hide()
		_1.show()
