extends Node2D

@onready var _1: TileMapLayer = $"1"
@onready var _2: TileMapLayer = $"2"


func _process(delta: float) -> void:
	if Global.gamestart == true:
		level_change()
		
	else: 
		for i in get_children():
			i.hide()
			i.collision_enabled = false
		
	if Global.tutorial == true:
		_1.show()
		_1.collision_enabled = true
	
	if Global.gameover == true:
		for i in get_children():
			i.hide()
			i.collision_enabled = false
	
	if Global.endless == true and Global.menuing == false:
		_1.show()
		_1.collision_enabled = true

func level_change():
	if Global.player_score >= 250 and Global.endless == false:
		Global.level += 1
		for i in get_children():
			i.hide()
			i.collision_enabled = false
		Global.menuing = true
		Global.gamestart = false
		Global.tutorial = false
		Global.player_score = 0
		Global.spawned = false
		
	else: 
		var current = get_children()[Global.level]
		current.show()
		current.collision_enabled = true
