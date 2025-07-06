extends Resource

class_name ToyData

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
};

@export var price: float = 5.0
@export var mesh: Mesh = CapsuleMesh.new()
@export var material_override: BaseMaterial3D;
@export var scale: Vector3 = Vector3(1.0, 1.0, 1.0)

func _init(Price=5.0, mesh=PlaceholderMesh.new(), scale=Vector3(1.0,1.0,1.0)) -> void:
	self.price = Price
	self.mesh = mesh
	self.scale = scale
