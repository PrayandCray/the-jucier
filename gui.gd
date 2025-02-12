extends Control
@onready var score: Label = $CanvasLayer/HBoxContainer/Score
@onready var time_limit: Label = $"CanvasLayer/HBoxContainer2/Time Limit"
@onready var time_limit_timer: Timer = $"Time Limit Timer"


var countdown_time = 0

func _ready() -> void:
	start_timer(120)

func _process(delta: float) -> void:
	countdown_time = time_limit_timer.time_left
	countdown_time = floor(countdown_time * 1) / 1
	score.text = "Score: " + str(Global.player_score)
	time_limit.text = str(countdown_time)
	if Global.level == 2:
		start_timer(120)

func start_timer(duration: float):
	var timer = get_tree().create_timer(duration)  # Creates a one-shot timer
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))


func _on_timer_timeout() -> void:
	get_tree().quit()
