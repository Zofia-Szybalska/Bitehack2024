extends CharacterBody3D

@export var speed = 10
@export var jump_velocity = 4.5

var look_sensitivity = ProjectSettings.get_setting("player/look_sensitivity")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0
var can_move = true

@onready var camera:Camera3D = $Camera3D

func lock_movement():
	can_move = false

func unlock_movement():
	can_move = true

func _physics_process(delta):
	if can_move:
		var horizontal_velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards").normalized() * speed
		velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z
		if is_on_floor():
			velocity_y = 0
			if Input.is_action_just_pressed("jump"):
				velocity_y = jump_velocity
		else:
			velocity_y -= gravity * delta
		velocity.y = velocity_y
		move_and_slide()
		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE


func _input(event):
	if can_move:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * look_sensitivity)
			camera.rotate_x(-event.relative.y * look_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)