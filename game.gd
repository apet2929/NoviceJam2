extends Node3D

@export var money: float = 0.0

@export var possible_boxes: Array[BoxData] = []
@export var rarity_mats: Dictionary[BoxData.Rarity, BaseMaterial3D] = {}

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
	self.money -= box.price
	play_swing()
	$UI/VSplitContainer/ColorRect2/BuyContainer.visible = false
	$UI/VSplitContainer/ColorRect2/NextContainer.visible = true
	
func play_swing():
	$Bat.visible = true
	$Bat/AnimationPlayer.play("swing")
	
func explode():
	$CerealBox.visible = false
	$CerealExplosion.restart()
	$CerealExplosion.emitting = true
	spawn_toy()
	%NextButton.disabled = false
	
func spawn_toy():
	$Toy.visible = true
	$Toy.load_toy($CerealBox.data.toy_mesh, null)
	
	
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
	
