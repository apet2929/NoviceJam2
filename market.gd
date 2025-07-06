extends Control

"""
Value of the toys inside the box (fast, chaotic)
Price of the box itself (slow, gradual)
"""

var points = []
var update_count = 0
var headers = ["Box name", "Toy 1", "Toy 2"]
var data = []
var last_prices = []
var current_prices = []
var next_prices = []
var t = 0

const SCROLL_RATE = 0.5 # updates per second

func get_market_price():
	return current_prices

func _ready() -> void:
	for header in headers:
		current_prices.append(0.0)
		last_prices.append(0.0)
		next_prices.append(0.0)
	await get_tree().create_timer(SCROLL_RATE).timeout
	
func update_prices():
	last_prices.clear()
	last_prices.append_array(current_prices)
	current_prices = next_prices
	for i in range(0, len(next_prices)):
		next_prices[i] = randf() - 0.5
	
func _draw():
	var bars = $Bars.get_children()
	for i in range(len(bars)):
		var bar: ColorRect = bars[i]
		var left = 10
		var right = bar.get_parent_area_size().x
		bar.custom_minimum_size.x = lerp(float(left), float(right), float(current_prices[i]))
	
func _process(delta) -> void:
	pass
	#t += delta * SCROLL_RATE
	#for i in range(len($Bars.get_children())):
		#current_prices[i] = lerp(last_prices[i], next_prices[i], t)
	
