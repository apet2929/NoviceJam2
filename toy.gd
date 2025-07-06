extends Node3D

func _ready():
	$AnimationPlayer.connect("animation_finished", self.spin)
	
func load_toy(toy: ToyData, rarity_mat: Material):
	$MeshInstance3D/AuraMesh.set_surface_override_material(0, rarity_mat)
	$MeshInstance3D/MeshInstance3D.mesh = toy.mesh
	$MeshInstance3D/MeshInstance3D.set_surface_override_material(0, toy.mesh.surface_get_material(0))
	$MeshInstance3D.scale = toy.scale
	$MeshInstance3D/AuraMesh.mesh = toy.mesh
	
	$AnimationPlayer.play("spawn")

func set_value_text(value):
	$Value.text = "Value: $" + str(value)
	
func spin(_cur_anim):
	$AnimationPlayer.play("spin")
