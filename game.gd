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
	%MuteButton.connect("button_up", self.mute)
	$Bat/AnimationPlayer.play("RESET")
	$Bat.visible = false
	$Toy.visible = false
	spawn_new_box()
	
func _process(delta: float) -> void:
	$UI/VSplitContainer/ColorRect2/Money.text = "Balance: " + str(self.money)

func mute():
	if $Music.playing:
		$Music.stop()
	else:
		$Music.play(0)

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

func play_sfx():
	$SFX.play(0.2)

const LEGENDARY_RARITY = 0.01
const RARE_RARITY = 0.1
const UNCOMMON_RARITY = 0.3
func spawn_toy():
	var rarityf = randf()
	var rarity = BoxData.Rarity.COMMON
	var rarity_mat = load("res://assets/rarities/common.tres")
	if rarityf < LEGENDARY_RARITY:
		rarity = BoxData.Rarity.LEGENDARY
		rarity_mat = load("res://assets/rarities/legendary.tres")
	elif rarityf < RARE_RARITY:
		rarity = BoxData.Rarity.RARE
		rarity_mat = load("res://assets/rarities/rare.tres")
	elif rarityf < UNCOMMON_RARITY:
		rarity = BoxData.Rarity.UNCOMMON
		rarity_mat = load("res://assets/rarities/uncommon.tres")
	else:
		rarity = BoxData.Rarity.COMMON
	
	rarity = BoxData.Rarity.RARE
	rarity_mat = load("res://assets/rarities/rare.tres")
		
	$Toy.visible = true
	var toy = $CerealBox.data.toys[selected_toy]
	$Toy.load_toy(toy, rarity_mat)
	self.money += toy.price
	
func spawn_new_box():
	var box_data = choose_random_box()
	$CerealBox.reset(box_data)
	$UI.load_box()
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
	
