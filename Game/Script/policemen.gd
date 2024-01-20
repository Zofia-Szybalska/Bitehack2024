extends CharacterBody3D

@onready var ray_cast: RayCast3D = $RayCast3D

func _physics_process(_delta):
	if ray_cast.is_colliding():
		pass
		#print("Policjant zauważył gracza.")
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create($RayCast3D.global_position,
			$RayCast3D.global_position - $RayCast3D.global_transform.basis.z * 100)
	var collision = space.intersect_ray(query)
	if collision:
		if collision.collider is CharacterBody3D and collision.collider.has_method("lock_movement"):
			print("Zauważono gracza.")
