extends Node3D
@export var item:PackedScene
var can_interact = false


func _process(_delta):
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			interact()

func interact():
	var item_i = item.instantiate()
	item.position = Vector3(0,0,0)
	get_tree().add_child(item_i)
	print("Interakcja z obiektem")

func _on_area_3d_body_entered(body):
	if body.has_method("lock_movement"):
		can_interact = true

func _on_area_3d_body_exited(body):
	if body.has_method("lock_movement"):
		can_interact = false
