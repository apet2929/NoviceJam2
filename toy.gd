extends Node3D

func load_toy(toy_mesh: Mesh, rarity_mat: BaseMaterial3D):
	$MeshInstance3D.mesh = toy_mesh
	$AnimationPlayer.play("spawn")
	$AnimationPlayer.connect("animation_finished", self.spin)
	
func spin(_cur_anim):
	$AnimationPlayer.play("spin")
