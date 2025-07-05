extends Node3D

func _ready():
	$AnimationPlayer.connect("animation_finished", self.spin)
	
func load_toy(toy_mesh: Mesh, rarity_mat: BaseMaterial3D):
	$MeshInstance3D.mesh = toy_mesh
	$AnimationPlayer.play("spawn")
	
func spin(_cur_anim):
	$AnimationPlayer.play("spin")
