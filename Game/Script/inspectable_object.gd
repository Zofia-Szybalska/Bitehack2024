extends Node3D

@export var camera: Camera3D

var pressed = false
var mouse = Vector2()
var pressed_on_dirt = false
var mouse_outside = true
@onready var mesh = $knife
func _input(event):
	if event is InputEventMouseButton and mouse_outside:
		pressed_on_dirt = false
	if pressed_on_dirt and event is InputEventMouseMotion:
		clean()
		return
	if pressed and event is InputEventMouseMotion:
		mesh.rotation.x += event.relative.y*0.005
		mesh.rotation.y += event.relative.x*0.005

func clean():
	if !mouse_outside:
		print("Czyszczone")

func _physics_process(_delta):
	if Input.is_action_just_pressed("click"):
		pressed = true
	elif Input.is_action_just_released("click"):
		pressed = false

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	mouse_outside = false
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			pressed_on_dirt = true
		elif Input.is_action_just_released("click"):
			pressed_on_dirt = false


func _on_area_3d_mouse_exited():
	mouse_outside = true

