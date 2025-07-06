extends Node3D

@onready var base_mat = $MeshInstance3D.get_surface_override_material(0)
func _ready():
	$AnimationPlayer.connect("animation_finished", self.spin)
	
func load_toy(toy: ToyData, rarity_mat: Material):
	$MeshInstance3D.mesh = toy.mesh
	if toy.material_override != null:
		$MeshInstance3D.set_surface_override_material(0, toy.material_override)
	else:
		if toy.mesh.surface_get_material(0) != null:
			$MeshInstance3D.set_surface_override_material(0, toy.mesh.surface_get_material(0))
		else:
			$MeshInstance3D.set_surface_override_material(0, base_mat)
	var mat: BaseMaterial3D = $MeshInstance3D.get_surface_override_material(0)
	mat.next_pass = rarity_mat
	$AnimationPlayer.play("spawn")
	
func spin(_cur_anim):
	$AnimationPlayer.play("spin")
