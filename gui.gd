extends Control
@onready var score: Label = $CanvasLayer/HBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"
@onready var button: Button = $CanvasLayer/HBoxContainer3/Button

var level = Global.level

var countdown_time = 0

func _ready() -> void:
	time_limit.hide()
	score.hide()
	pass

func _process(delta: float) -> void:
	countdown_time = time_limit_timer.time_left
	countdown_time = floor(countdown_time * 1) / 1
	score.text = "Score: " + str(Global.player_score)
	time_limit.text = str(countdown_time)
	if Global.level != level:
		time_limit_timer.stop()
		level += 1
		time_limit_timer.start()

func _on_timer_timeout() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	Global.gamestart = true
	time_limit_timer.start()
	button.hide()
	score.show()
	time_limit.show()
