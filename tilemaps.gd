extends Node2D

@onready var _1: TileMapLayer = $"1"
@onready var _2: TileMapLayer = $"2"


func _process(delta: float) -> void:
	#print(Global.customers_served)
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
	
	if Global.endless == true and Global.gamestart == true:
		_1.show()
		_1.collision_enabled = true

func level_change():
	if Global.customers_served >= Global.customers_in_levels[Global.level] and Global.endless == false:
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
		if Global.endless == false and Global.tutorial == false:
			var current = get_children()[Global.level]
			current.show()
			current.collision_enabled = true
		else:
			Global.level = 0
			for i in get_children():
				if i == $"1":
					i.show()
					i.collision_enabled = true
				else:
					i.hide()
					i.collision_enabled = false
