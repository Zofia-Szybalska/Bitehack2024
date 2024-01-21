extends CharacterBody3D

@onready var ray_cast: RayCast3D = $RayCast3D

func reset(message):
	Globals.reset(message)
	get_tree().reload_current_scene()

func _physics_process(_delta):
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create($RayCast3D.global_position,
			$RayCast3D.global_position - $RayCast3D.global_transform.basis.z * 100)
	var collision = space.intersect_ray(query)
	if collision:
		if collision.collider is CharacterBody3D and collision.collider.has_method("lock_movement"):
			if collision.collider.is_doing_evil:
				if !Globals.caugth:
					Globals.caugth = true
					Globals.add_achivment(load("res://Achievements/2.tres"))
				reset("Policjant cię złapał, trafiłeś do więzienia, ale dzięki twojemu szczęściu czas się cofnął i możesz spróbowac raz jeszcze.")

