extends Timer

var timer_started = false

#func _on_area_2d_body_entered(body: Node2D) -> void:
#	if body is TileMapLayer and  timer_started == false:
#		timer_started = true
#		start()
#		print("started")

func _on_timeout() -> void:
	get_parent().duplicate_fruit()
	get_parent().queue_free()
	timer_started = false
