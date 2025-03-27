extends Control

@onready var v_box_container: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var smoothie: TextureRect = $CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer2/Smoothie
@onready var fruit_basket: TextureRect = $"CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Fruit Basket"
@onready var score: Label = $CanvasLayer/HBoxContainer/VBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"
@onready var game_name: Label = $"CanvasLayer/VBoxContainer/Game Name"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/Start_Button
@onready var endless: Button = $CanvasLayer/VBoxContainer/HBoxContainer/endless
@onready var combos: Label = $CanvasLayer/Combos
@onready var combo_timer: Timer = $"Combo Timer"
@onready var tutorial: Button = $CanvasLayer/VBoxContainer/HBoxContainer/tutorial
@onready var tutorial_hbox: HBoxContainer = $"CanvasLayer/Tutorial Hbox"
@onready var game_over: Label = $"CanvasLayer/Game Over"
@onready var current_fruits: Label = $"CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Current Fruits"
@onready var current_smoothies: Label = $"CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer2/Current Smoothies"
@onready var customer_icon: TextureRect = $"CanvasLayer/HBoxContainer/VBoxContainer/Customer_box/Customer Icon"
@onready var customer_box: HBoxContainer = $CanvasLayer/HBoxContainer/VBoxContainer/Customer_box
@onready var _1_w: TextureRect = $"CanvasLayer/Tutorial Hbox/1_w"
@onready var _1_a: TextureRect = $"CanvasLayer/Tutorial Hbox/1_a"
@onready var _1_d: TextureRect = $"CanvasLayer/Tutorial Hbox/1_d"

var level = Global.level
var text = 0
var countdown_time = 0
var tutorial_level = 0
var customers_spawned = false
var setup = false
var tutorial_progress = 0

func _physics_process(delta: float) -> void:

	if Global.menuing == true:
		menu_setup()
		Global.comboed_timeout = true
		Global.comboed = false
		Global.fruit_sfx_pitch_scale = 0
		setup = false
		
	if Global.endless == true:
		endless.icon = load("res://Self-Made Art/gui/endless_activated.png")
	if Global.endless == false:
		endless.icon = load("res://Self-Made Art/gui/endless.png")
		
	var global_player_fruit_string = str(Global.player_fruits)
	var global_smoothies_string = str(Global.smoothies)
	
	if Global.gamestart == true:
		if setup == false:
			gui_setup()
			setup = true
		
		current_fruits.text = str(global_player_fruit_string, " / ", (Global.basket_size + 1))
		current_smoothies.text = str(global_smoothies_string, " / ", Global.smoothie_limit)
		if Global.player_fruits < 5:
			fruit_basket.texture = load("res://Self-Made Art/fruits/fruit_basket.png")
		else:
			fruit_basket.texture = load("res://Self-Made Art/fruits/fruit_basket_full.png")
		
			
		if Global.endless == false:
			countdown_time = floor(int(time_limit_timer.time_left))
			score.text = "Score: " + str(Global.player_score)
			time_limit.text = str(countdown_time)
			if Global.level != level:
				time_limit_timer.stop()
				level += 1
				time_limit_timer.start()
				
		elif Global.endless == true:
			time_limit.text = "endless"
			score.text = "Score: " + str(Global.player_score)
			current_smoothies.text = str(global_smoothies_string, " /  infinity")

		if Global.comboed == true:
			Global.fruit_sfx_pitch_scale += 0.025
			text = str(int(combos.text) + 1)
			combos.text = text
			Global.combo_restart = true
			Global.comboed = false
			if int(combos.text) > 1:
				combos.show()
		combos.set_position(Vector2((Global.player_x + 25 - randi_range(-5, 5)), Global.player_y - 3 + (randi_range(1, 4)))) #jitter text for combo text
		
		if Global.comboed_timeout == true:
			combos.hide()
			Global.player_score += (int(combos.text) * 5)
			combos.text = "0"
			Global.fruit_sfx_pitch_scale = 0
			Global.comboed_timeout = false
			
		if Global.sold_smoothies >= 1 and Global.endless == false:
			for customers in Global.sold_smoothies:
				customer_box.get_children().back().queue_free()
				Global.sold_smoothies -= 0.5


	if Global.tutorial == true:
		Global.gamestart = true
		Global.endless = true
		print(tutorial_progress)
		if setup == false:
			gui_setup()
			tutorial_progress = 0
			Global.blender_show = false
			_1_a.show()
			_1_w.show()
			_1_d.show()
			setup = true
		tutorial_hbox.show()
		tutorial_level = 1
		if tutorial_level == 1:
			if Input.is_action_just_pressed("Jump"):
				for child in tutorial_hbox.get_children():
					if child.name == "1_w":
						if child.visible == true:
							tutorial_progress += 1
						child.hide()
			if Input.is_action_just_pressed("Left"):
				for child in tutorial_hbox.get_children():
					if child.name == "1_a":
						if child.visible == true:
							tutorial_progress += 1
						child.hide()
			if Input.is_action_just_pressed("Right"):
				for child in tutorial_hbox.get_children():
					if child.name == "1_d":
						if child.visible == true:
							tutorial_progress += 1
						child.hide()
			if tutorial_progress == 3 and tutorial_level == 1:
				tutorial_progress = 0
				tutorial_level = 2
		if tutorial_level == 2:
			Global.blender_show = true

func _on_timer_timeout() -> void:
	Global.gameover = true
	game_over.show()
	endless.hide()
	tutorial.hide()
	game_name.hide()
	score.hide()
	time_limit.hide()
	current_fruits.hide()
	current_smoothies.hide()
	smoothie.hide()
	fruit_basket.hide()
	customer_box.get_children().clear()

func _on_button_pressed() -> void:
	Global.gamestart = true
	time_limit_timer.start()
	start_button.hide()
	endless.hide()
	tutorial.hide()
	game_name.hide()
	score.show()
	time_limit.show()
	current_fruits.show()
	current_smoothies.show()
	smoothie.show()
	fruit_basket.show()
	if Global.endless == false:
		for i in customer_box.get_children():
			i.hide()

func _on_endless_pressed() -> void:

	if Global.endless == false:
		endless.icon = load("res://Self-Made Art/gui/endless_activated.png")
		Global.endless = true
		
	elif Global.endless == true:
		endless.icon = load("res://Self-Made Art/gui/endless.png")
		Global.endless = false
		
func _on_tutorial_pressed() -> void:
	Global.tutorial = true
	start_button.hide()
	endless.hide()
	tutorial.hide()
	game_name.hide()
	tutorial_hbox.hide()
	
func gui_setup():
	Global.menuing = false
	if customers_spawned == false and Global.endless == false:
		for i in customer_box.get_children():
			i.show()
		for i in range(Global.customer_count):
			var new_customer = customer_icon.duplicate()
			customer_box.add_child(new_customer)
			new_customer.show()
		customers_spawned = true
	if Global.endless == true and customers_spawned == true:
		for i in customer_box.get_children():
			i.hide()
			if i == $"CanvasLayer/HBoxContainer/VBoxContainer/Customer_box/Customer Icon":
				i.hide()
				customers_spawned = false
			else:
				i.queue_free()
	time_limit.show()
	score.show()
	current_fruits.show()
	current_smoothies.show()
	smoothie.show()
	fruit_basket.show()
	customer_box.show()
	game_name.hide()
	start_button.hide()
	endless.hide()
	tutorial.hide()
	
func menu_setup():
	for i in customer_box.get_children():
		i.hide()
		if i == $"CanvasLayer/HBoxContainer/VBoxContainer/Customer_box/Customer Icon":
			i.hide()
			customers_spawned = false
		else:
			i.queue_free()
	Global.customer_count = 15
	combos.hide()
	time_limit.hide()
	tutorial_hbox.hide()
	score.hide()
	current_fruits.hide()
	current_smoothies.hide()
	smoothie.hide()
	fruit_basket.hide()
	customer_box.hide()
	game_name.show()
	start_button.show()
	endless.show()
	tutorial.show()
