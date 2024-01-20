extends Node3D

var can_interact = false


func _process(_delta):
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			interact()

func interact():
	print("Interakcja z obiektem")

func _on_area_3d_body_entered(body):
	if body.has_method("lock_movement"):
		can_interact = true

func _on_area_3d_body_exited(body):
	if body.has_method("lock_movement"):
		can_interact = false
