extends Control

@onready var score: Label = $CanvasLayer/HBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"
@onready var game_name: Label = $"CanvasLayer/VBoxContainer/Game Name"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/Start_Button
@onready var endless: Button = $CanvasLayer/VBoxContainer/endless
@onready var combos: Label = $CanvasLayer/Combos

var level = Global.level
var text = 0
var countdown_time = 0

func _ready() -> void:
	combos.hide()
	time_limit.hide()
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
			combos.show()
			text = str(int(combos.text) + 1)
			print("combos text, ", text)
			combos.text = text
			Global.comboed = false
		combos.set_position(Vector2((Global.player_x + 25 - randi_range(-5, 5)), Global.player_y - 3 + (randi_range(1, 4)))) #jitter text for combo text
		
		if Global.comboed_timeout == true:
			combos.hide()
			Global.player_score += (int(combos.text) * 5)
			combos.text = "0"
			Global.comboed_timeout = false

func _on_timer_timeout() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	Global.gamestart = true
	time_limit_timer.start()
	start_button.hide()
	endless.hide()
	game_name.hide()
	score.show()
	time_limit.show()

func _on_endless_pressed() -> void:
	Global.endless = true
	endless.hide()
