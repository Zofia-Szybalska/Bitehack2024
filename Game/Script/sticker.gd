extends Node3D

var player_in_range = false
signal player_entered_range(sticker)
signal player_exited_range

func _on_area_3d_body_entered(body):
	if body.has_method("lock_movement"):
		player_entered_range.emit(self)
		player_in_range = true

func collect():
	if player_in_range:
		Globals.add_sticker()
		queue_free()

func _on_area_3d_body_exited(body):
	if body.has_method("lock_movement"):
		player_exited_range.emit()
		player_in_range = false
