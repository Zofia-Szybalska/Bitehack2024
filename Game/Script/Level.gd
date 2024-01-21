extends Node3D

@onready var notes  = $Notes
@onready var player = $Player
@onready var path1 = $Path3D/PathFollow3D

const pol_move_speed := 2.0

func _process(_delta):
	if Globals.collected_achievements == Globals.max_achievements:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://Scenes/You won.tscn")
	if Input.is_action_just_pressed("show_Notes"):
		notes.visible = !notes.visible
		if notes.visible:
			notes.load_notes()
			player.lock_movement()
		else:
			player.unlock_movement()

func _physics_process(delta):
	path1.progress += pol_move_speed * delta

func reset(mess):
	Globals.reset(mess)
#	get_tree().reload_current_scene()

func _on_timer_timeout():
	Globals.add_achivment(load("res://Achievements/4.tres"))
	reset("Czas ci się skończył, nie dasz rady podmienić dowodów, złapią cię.")
