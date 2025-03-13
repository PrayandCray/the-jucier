extends Sprite2D

var common_fruit_sprites = [
	load("res://Self-Made Art/fruits/pear.png"),
	load("res://Self-Made Art/fruits/strawberry.png"),
	load("res://Self-Made Art/fruits/bananna.png"),
	load("res://Self-Made Art/fruits/apple.png")
	
]


var rare_fruit_sprites = [
	load("res://Self-Made Art/fruits/watermelon.png"),
	load("res://Self-Made Art/fruits/grapes.png"),
	load("res://Self-Made Art/fruits/kiwi.png"),
	load("res://Self-Made Art/fruits/coconut.png")
	
]

var powerups = [
	load("res://Self-Made Art/fruits/speed_power.png"),
	load("res://Self-Made Art/fruits/strawberry.png")
	
]

func _ready() -> void:
	var rarity = randi_range(1, 100)
	if rarity <= 50:
		texture = common_fruit_sprites.pick_random()
		scale *= 6
	if rarity > 50 and rarity < 80:
		texture = rare_fruit_sprites.pick_random()
		scale *= 6
	if rarity >= 80 and rarity < 90:
		texture = powerups.front()
		get_parent().speed_power = true
		scale *= 3
	if rarity >= 90:
		texture = powerups.back()
		get_parent().fruit_x2 = true
		scale *= 4
