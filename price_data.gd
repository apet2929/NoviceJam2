class_name PriceData

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
};


var base_price = 10
var range = 0.5 # % of base price
var update_rate = 2 # 2 per second
var time_to_gen = 10
var data = [] # eg [0.5, 0.0, -0.1] etc

func _init(base_price, range, update_rate, time_to_gen):
	self.base_price = base_price
	self.range = range
	self.update_rate = update_rate
	self.time_to_gen = time_to_gen
	self.data = []
	for t in range(0, 10 * update_rate): # generate 10 seconds of data
		var v = randf_range(0, range)
		self.data.append(v)
	
