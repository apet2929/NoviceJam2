extends Node3D

class_name Box

@export var rot_speed: float = 1.0; # rps
@export var data: BoxData;

var rarity: BoxData.Rarity

var mat_loaded = false;

const LEGENDARY_RARITY = 0.01
const RARE_RARITY = 0.1
const UNCOMMON_RARITY = 0.3

func reset(box_data: BoxData):
	self.data = box_data
	self.mat_loaded = false
	
	self.visible = true
	

func _process(delta: float) -> void:
	if not mat_loaded:
		if self.data.material != null:
			$MeshInstance3D.set_surface_override_material(0,  self.data.material)
			mat_loaded = true
			var mat =  $MeshInstance3D/MeshInstance3D.get_surface_override_material(0)
			mat.albedo_texture = self.data.brand_texture
			
			
	self.rotate_y(rot_speed * 2.0 * PI * delta);
