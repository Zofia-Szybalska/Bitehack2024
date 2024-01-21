extends Node3D


@export var player: CharacterBody3D
var can_interact = false
var locked_on_object = false
var pressed_on_dirt = false
var pressed = false
var cleaning_timer = false
var mouse_outside = true
var cleanage = 1.0
var cleaned = false
signal item_cleaned
var discovered = false

func footprint():
	pass

func clean():
	if !(mouse_outside and cleaning_timer):
		cleanage -= 0.03
		if cleanage < 0 and !cleaned:
			cleaned = true
			unlock_camera()
			queue_free()
			item_cleaned.emit()
		cleaning_timer = true
		$Timer.start()

func _process(_delta):
	if locked_on_object and Input.is_action_just_pressed("ui_cancel"):
		unlock_camera()
	if can_interact:
		if Input.is_action_just_pressed("interact") and player.see_footprint():
			lock_camera()
			if !discovered:
				discovered = true
				Globals.add_clue("Odcisk buta")
	if Input.is_action_just_pressed("click"):
		pressed = true
	elif Input.is_action_just_released("click"):
		pressed = false

func _input(event):
	if pressed_on_dirt and event is InputEventMouseMotion:
		clean()
		return

func unlock_camera():
	player.unlock_movement()
	locked_on_object = false

func lock_camera():
	player.lock_movement()
	locked_on_object = true

func _on_area_3d_body_exited(_body):
	can_interact = false

func _on_area_3d_body_entered(_body):
	can_interact = true

func _on_area_3d_2_input_event(_camera, event, _position, _normal, _shape_idx):
	mouse_outside = false
	if locked_on_object:
		if event is InputEventMouseButton:
			if Input.is_action_just_pressed("click"):
				pressed_on_dirt = true
				player.is_doing_evil = true
			elif Input.is_action_just_released("click"):
				pressed_on_dirt = false
				player.is_doing_evil = false

func _on_timer_timeout():
	cleaning_timer = false

func _on_area_3d_2_mouse_exited():
	mouse_outside = true
