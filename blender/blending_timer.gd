extends Timer

func _process(delta: float) -> void:
	if Global.blender_started == true and time_left <= 0:
		start()
		get_parent().play("Blending")

func _on_timeout() -> void:
	stop()
	get_parent().play("Empty")
	Global.blender_started = false
	Global.smoothies += 1
