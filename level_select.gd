extends Button
@onready var time_limit_timer: Timer = $"../../../Time Limit Timer"

func _pressed() -> void:
	Global.level = int(get_name()) - 1
	Global.customer_count = get_parent().get_parent().get_parent().customers_in_levels[Global.level]
	Global.level_select = false
	for child in get_parent().get_children():
		child.hide()
	
	Global.gamestart = true
	time_limit_timer.start()
	get_parent().get_parent().get_parent().start_button.hide()
	get_parent().get_parent().get_parent().endless.hide()
	get_parent().get_parent().get_parent().tutorial.hide()
	get_parent().get_parent().get_parent().game_name.hide()
	get_parent().get_parent().get_parent().score.show()
	get_parent().get_parent().get_parent().time_limit.show()
	get_parent().get_parent().get_parent().current_fruits.show()
	get_parent().get_parent().get_parent().current_smoothies.show()
	get_parent().get_parent().get_parent().smoothie.show()
	get_parent().get_parent().get_parent().fruit_basket.show()
	if Global.endless == false:
		for i in get_parent().get_parent().get_parent().customer_box.get_children():
			i.hide()
