extends Control

@onready var smoothie: TextureRect = $CanvasLayer/Smoothie
@onready var fruit_basket: TextureRect = $"CanvasLayer/Fruit Basket"
@onready var score: Label = $CanvasLayer/HBoxContainer/VBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"
@onready var game_name: Label = $"CanvasLayer/VBoxContainer/Game Name"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/Start_Button
@onready var endless: Button = $CanvasLayer/VBoxContainer/endless
@onready var combos: Label = $CanvasLayer/Combos
@onready var tutorial: Button = $CanvasLayer/VBoxContainer/tutorial
@onready var tutorial_screen: TextureRect = $"CanvasLayer/Tutorial Screen"
@onready var game_over: Label = $"CanvasLayer/Game Over"
@onready var current_fruits: Label = $"CanvasLayer/HBoxContainer/VBoxContainer/Current Fruits"
@onready var current_smoothies: Label = $"CanvasLayer/HBoxContainer/VBoxContainer/Current Smoothies"
@onready var customer_icon: TextureRect = $"CanvasLayer/HBoxContainer/VBoxContainer/Customer_box/Customer Icon"
@onready var customer_box: HBoxContainer = $CanvasLayer/HBoxContainer/VBoxContainer/Customer_box

var level = Global.level
var text = 0
var countdown_time = 0

func _ready() -> void:
	combos.hide()
	time_limit.hide()
	tutorial_screen.hide()
	score.hide()
	current_fruits.hide()
	current_smoothies.hide()
	smoothie.hide()
	fruit_basket.hide()
	customer_icon.hide()

func _process(delta: float) -> void:
	print(Global.sold_smoothies)
	var global_player_fruit_string = str(Global.player_fruits)
	var global_smoothies_string = str(Global.smoothies)
	if Global.gamestart == true:
		current_fruits.text = str(global_player_fruit_string, " / ", (Global.basket_size + 1))
		current_smoothies.text = str(global_smoothies_string, " / ", Global.smoothie_limit)
		if Global.player_fruits < 5:
			fruit_basket.texture = load("res://Self-Made Art/fruits/fruit_basket.png")
		else:
			fruit_basket.texture = load("res://Self-Made Art/fruits/fruit_basket_full.png")
		
			
		if Global.endless == false:
			countdown_time = time_limit_timer.time_left
			countdown_time = floor(countdown_time * 1) / 1
			score.text = "Score: " + str(Global.player_score)
			time_limit.text = str(countdown_time)
			if Global.level != level:
				time_limit_timer.stop()
				level += 1
				time_limit_timer.start()
				
		elif Global.endless == true:
			customer_icon.hide()
			countdown_time = "endless"
			score.text = "Score: " + str(Global.player_score)

		if Global.comboed == true:
			Global.fruit_sfx_pitch_scale += 0.025
			text = str(int(combos.text) + 1)
			combos.text = text
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
			
		if Global.sold_smoothies >= 1:
			for customers in Global.sold_smoothies:
				customer_box.get_children().front().queue_free()
				Global.sold_smoothies -= 0.5
				
	
	if Global.tutorial == true:
		tutorial_screen.show()

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
	for i in range(Global.customer_count):
		var new_customer = customer_icon.duplicate()
		customer_box.add_child(new_customer)
		new_customer.show()
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
	customer_icon.show()

func _on_endless_pressed() -> void:
	if endless.toggle_mode == true:
		Global.endless = false
		endless.add_theme_color_override("font_hover_color", Color.RED)
		endless.toggle_mode = false
	else: 
		Global.endless = true
		endless.add_theme_color_override("font_hover_color", Color.GREEN)
		endless.toggle_mode = true

func _on_tutorial_pressed() -> void:
	Global.tutorial = true
	start_button.hide()
	endless.hide()
	tutorial.hide()
	game_name.hide()
	tutorial_screen.show()
