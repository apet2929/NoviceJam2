extends Node3D

class_name Box

@export var rot_speed: float = 1.0; # rps
@export var data: BoxData;

var rarity: BoxData.Rarity

var mat_loaded = false;

const LEGENDARY_RARITY = 0.01
const RARE_RARITY = 0.1
const UNCOMMON_RARITY = 0.3

func reset(box_data: BoxData, rarityf: float):
	self.data = box_data
	self.mat_loaded = false
	
	if rarityf < LEGENDARY_RARITY:
		self.rarity = BoxData.Rarity.LEGENDARY
	elif rarityf < RARE_RARITY:
		self.rarity = BoxData.Rarity.RARE
	elif rarityf < UNCOMMON_RARITY:
		self.rarity = BoxData.Rarity.UNCOMMON
	else:
		self.rarity = BoxData.Rarity.COMMON
	
	print(BoxData.Rarity.keys()[self.rarity])
	
	self.visible = true
	

func _process(delta: float) -> void:
	if not mat_loaded:
		if self.data.material != null:
			#self.data.material.next_pass = 
			$MeshInstance3D.set_surface_override_material(0,  self.data.material)
			mat_loaded = true
			
	self.rotate_y(rot_speed * 2.0 * PI * delta);
