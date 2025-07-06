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
	
	update_prices()

func update_prices():
	last_prices.clear()
	last_prices.append_array(current_prices)
	current_prices = []
	current_prices.append_array(next_prices)
	for i in range(0, len(next_prices)):
		next_prices[i] = randf() - 0.5
	
func _draw():
	var bars = $Bars.get_children()
	var left = 10
	
	for i in range(len(bars)):
		var bar: ColorRect = bars[i]
		var right = bar.get_parent_area_size().x
		bar.custom_minimum_size.x = lerp(float(left), float(right), current_prices[i] + 0.5)

func _process(delta) -> void:
	queue_redraw()
	t += delta * SCROLL_RATE
	
	for i in range(len($Bars.get_children())):
		current_prices[i] = lerp(float(last_prices[i]), float(next_prices[i]), t)
		if t > 1:
			current_prices[i] = next_prices[i]
	
	if t > 1:
		update_prices()
		t = 0
	
	
