extends Node3D

@export var money: float = 0.0

@export var possible_boxes: Array[BoxData] = []
@export var rarity_mats: Dictionary[BoxData.Rarity, BaseMaterial3D] = {}
var selected_toy = -1 # selected_toy either 0 (first toy) or 1 (second toy)

func _ready() -> void:
	$CerealExplosion.emitting = false
	%BuyButton.connect("button_up", self.buy_box)
	%NextButton.connect("button_up", self.spawn_new_box)
	%SkipButton.connect("button_up", self.spawn_new_box)
	$Bat/AnimationPlayer.play("RESET")
	$Bat.visible = false
	$Toy.visible = false
	spawn_new_box()

func buy_box():
	var box = $CerealBox.data
	var prices = %PriceGraph.get_market_price() # [box price, toy 1 price, toy 2 price]
	self.money -= prices[0]
	self.selected_toy = 0 if randf() > 0.5 else 1
	self.money += prices[selected_toy + 1]
	
	play_swing()
	$UI/VSplitContainer/ColorRect2/BuyContainer.visible = false
	$UI/VSplitContainer/ColorRect2/NextContainer.visible = true

func play_swing():
	$Bat.visible = true
	var anims = $Bat/AnimationPlayer.get_animation_list()
	var anim_id = randi_range(1, len(anims)-1)
	var selected_anim = anims[anim_id]
	print(anim_id)
	$Bat/AnimationPlayer.play(selected_anim)
	print(selected_anim)
	
func explode():
	$CerealBox.visible = false
	$CerealExplosion.restart()
	$CerealExplosion.emitting = true
	spawn_toy()
	%NextButton.disabled = false
	
func spawn_toy():
	$Toy.visible = true
	print(selected_toy)
	$Toy.load_toy($CerealBox.data.toy_meshes[selected_toy], null)
	
	
func spawn_new_box():
	var rarity = randf()
	$CerealBox.reset(choose_random_box(), rarity)
	$UI/VSplitContainer/ColorRect2/BuyContainer.visible = true
	$UI/VSplitContainer/ColorRect2/NextContainer.visible = false
	$Bat/AnimationPlayer.play("RESET")
	$Bat.visible = false
	%NextButton.disabled = true
	$Toy/AnimationPlayer.play("RESET")
	$Toy.visible = false

func choose_random_box() -> BoxData:	
	var index = randi_range(0, len(self.possible_boxes)-1)
	var selected = self.possible_boxes[index]
	return selected
	
