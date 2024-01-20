extends Node3D
@export var item:PackedScene
var item_cleanage = 0.0
@export var player:CharacterBody3D
var can_interact = false
var item_showed = false
var item_i

func _process(_delta):
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			if item_showed:
				pass
			else:
				interact()

func interact():
	item_i = item.instantiate()
	item_i.player = $"../Player"
	item_i.position = player.camera.project_position(get_viewport().get_mouse_position(), 0.5)
	item_i.rotation = player.rotation
	item_i.cleanage = item_cleanage
	item_i.item_cleaned.connect(hide_item)
	item_i.exited.connect(exit_item)
	get_tree().root.add_child(item_i)
	item_showed = true
	player.lock_movement()

func hide_item():
	item_i.queue_free()
	player.unlock_movement()

func exit_item(cleanage):
	item_showed = false
	item_cleanage = cleanage
	item_i.queue_free()
	player.unlock_movement()

func _on_area_3d_body_exited(body):
	if body.has_method("lock_movement"):
		can_interact = false

func _on_area_3d_body_entered(body):
	if body.has_method("lock_movement"):
		can_interact = true
