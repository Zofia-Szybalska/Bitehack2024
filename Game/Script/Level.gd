extends Node3D

@onready var notes  = $Notes
@onready var player = $Player
@onready var path1 = $Path3D/PathFollow3D

const pol_move_speed := 4.0

func _process(_delta):
	if Input.is_action_just_pressed("show_Notes"):
		notes.visible = !notes.visible
		if notes.visible:
			player.lock_movement()
		else:
			player.unlock_movement()

func _physics_process(delta):
	path1.progress += pol_move_speed * delta
