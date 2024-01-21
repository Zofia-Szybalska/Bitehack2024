extends Node3D


@export var player: CharacterBody3D
signal item_cleaned
var discovered = false
var is_near = false

func _ready():
	player = Globals.player

func cigarette():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("interact") and player.see_cigarette() and is_near:
		player.is_doing_evil = true
		$Timer2.start()
		if !discovered:
			discovered = true
			Globals.add_clue("Niedopałki")

func _on_timer_2_timeout():
	player.is_doing_evil = false
	Globals.remove_clue()
	queue_free()


func _on_area_3d_body_entered(_body):
	is_near = true


func _on_area_3d_body_exited(_body):
	is_near = false
