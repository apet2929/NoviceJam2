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

func _ready() -> void:
	for header in headers:
		data.append(PriceData.new(10, 0.3, 0.5, 10))
	
func _draw():
	var bars = $Bars.get_children()
	for i in range(len(bars)):
		var bar: ColorRect = bars[i]
		var left = 10
		var right = bar.get_parent_area_size().x
		bar.custom_minimum_size.x = lerp(left, right, current_prices[i])
	
func _process(delta) -> void:
	t += delta * SCROLL_RATE
	for i in range(len($Bars.get_children())):
		current_prices[i] = lerp(last_prices[i], next_prices[i], t)
	
