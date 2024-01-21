extends Node3D

var camera: Camera3D
@export var player: CharacterBody3D

var pressed = false
var mouse = Vector2()
var pressed_on_dirt = false
var mouse_outside = true
@onready var mesh = $"bloody knife"
var cleanage = 1.0
var cleaning_timer = false
var cleaned = false
signal item_cleaned
signal exited

func _ready():
	camera = player.camera

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
	if !(mouse_outside and cleaning_timer):
		cleanage -= 0.03
		if cleanage < 0 and !cleaned:
			cleaned = true
			$"bloody knife/Area3DDirt/CollisionShape3D/Fingerprints".queue_free()
			player.is_doing_evil = false
			item_cleaned.emit()
		cleaning_timer = true
		$Timer.start()

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		exited.emit(cleanage)
	if Input.is_action_just_pressed("click"):
		pressed = true
	elif Input.is_action_just_released("click"):
		pressed = false

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	mouse_outside = false
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			pressed_on_dirt = true
			player.is_doing_evil = true
		elif Input.is_action_just_released("click"):
			pressed_on_dirt = false
			player.is_doing_evil = false

func _on_area_3d_mouse_exited():
	mouse_outside = true

func _on_timer_timeout():
	cleaning_timer = false
