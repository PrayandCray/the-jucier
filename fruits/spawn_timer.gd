extends Timer

var timer_started = false

func _ready() -> void:
	start(5)

#func _process(delta: float) -> void:
	#print(time_left)

func _on_timeout() -> void:
	stop()
	get_parent().queue_free()
	print("die")
