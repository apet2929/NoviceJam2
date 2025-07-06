extends Control

@onready var box: Box = %CerealBox
@onready var box_name = $VSplitContainer/ColorRect/VBoxContainer/BoxName
@onready var manufacturer = $VSplitContainer/ColorRect/VBoxContainer/Manufacturer
@onready var description = $VSplitContainer/ColorRect2/Description
@onready var price = $VSplitContainer/ColorRect2/Price

func _ready() -> void:
	self.load_box()
	
func load_box():
	box_name.text = "Name: " + box.data.name;
	manufacturer.text = "Manufacturer: " + box.data.manufacturer
	description.text = "Description: \n" +  box.data.description
	price.text = "Cost: $" + str(box.data.price);
