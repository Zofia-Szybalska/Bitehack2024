extends Node3D

@onready var notes  = $Notes
@onready var player = $Player

func _process(delta):
	if Input.is_action_just_pressed("show_Notes"):
		notes.visible = !notes.visible
		if notes.visible:
			player.lock_movement()
		else:
			player.unlock_movement()
