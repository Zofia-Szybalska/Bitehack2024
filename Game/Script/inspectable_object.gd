extends Node3D

@export var camera: Camera3D

var pressed = false
var mouse = Vector2()
var pressed_on_dirt = false

func _input(event):
	if pressed_on_dirt and event is InputEventMouseMotion:
		clean()
		return
	if pressed and event is InputEventMouseMotion:
		$MeshInstance3D.rotation.x += event.relative.y*0.005
		$MeshInstance3D.rotation.y += event.relative.x*0.005

func clean():
	print("Czyszczone")

func _physics_process(_delta):
	if Input.is_action_just_pressed("click"):
		pressed = true
	elif Input.is_action_just_released("click"):
		pressed = false

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			pressed_on_dirt = true
		elif Input.is_action_just_released("click"):
			pressed_on_dirt = false
