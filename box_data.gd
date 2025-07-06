extends Resource

class_name BoxData

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
};



@export var name: String;
@export var price: float;
@export var description: String;
@export var manufacturer: String;
@export var material: BaseMaterial3D;
@export var toys: Array[ToyData];
@export var brand_texture: Texture;

func _init(Price=0.0, Name="Debug", Description="", Manufacturer=""):
	self.price = Price
	self.name = Name
	self.description = Description
	self.manufacturer = Manufacturer
	
	
