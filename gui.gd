extends Control

@onready var score: Label = $CanvasLayer/HBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"
@onready var game_name: Label = $"CanvasLayer/VBoxContainer/Game Name"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/Start_Button
@onready var endless: Button = $CanvasLayer/VBoxContainer/endless
@onready var combos: Label = $CanvasLayer/Combos
@onready var tutorial: Button = $CanvasLayer/VBoxContainer/tutorial
@onready var tutorial_screen: TextureRect = $"CanvasLayer/Tutorial Screen"

var level = Global.level
var text = 0
var countdown_time = 0

func _ready() -> void:
	combos.hide()
	time_limit.hide()
	tutorial_screen.hide()
	score.hide()
	pass

func _process(delta: float) -> void:
	if Global.gamestart == true:
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
			countdown_time = "endless"
			score.text = "Score: " + str(Global.player_score)
			
		
		if Global.comboed == true:
			text = str(int(combos.text) + 1)
			print("combos text, ", text)
			combos.text = text
			Global.comboed = false
			if int(combos.text) > 1:
				combos.show()
		combos.set_position(Vector2((Global.player_x + 25 - randi_range(-5, 5)), Global.player_y - 3 + (randi_range(1, 4)))) #jitter text for combo text
		
		if Global.comboed_timeout == true:
			combos.hide()
			Global.player_score += (int(combos.text) * 5)
			combos.text = "0"
			Global.comboed_timeout = false
	
	if Global.tutorial == true:
		tutorial_screen.show()

func _on_timer_timeout() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	Global.gamestart = true
	time_limit_timer.start()
	start_button.hide()
	endless.hide()
	tutorial.hide()
	game_name.hide()
	score.show()
	time_limit.show()

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
