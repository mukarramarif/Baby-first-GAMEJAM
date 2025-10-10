extends Node3D

@onready var camera: Camera3D = $"../Camera3D"
var current_object : StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

signal click_signal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 100
	var from = camera.project_ray_origin(mousePos)
	var to = from + camera.project_ray_normal(mousePos) * rayLength
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = from
	rayQuery.to = to
	rayQuery.collide_with_areas = true
	rayQuery.collide_with_bodies = true  # Make sure to also collide with bodies if needed

	var result = space.intersect_ray(rayQuery)
	if result:
		if result.collider is StaticBody3D:
			current_object = result.collider
	else:
		current_object = null
	#print(current_object)
	#if !current_object:
		#pass
		#if active_scene:
			#active_scene.set_curso r_type(current_object) # use the set_cursor_type for the active scene
	#print(result)

func reset_game() -> void:
	pass

func get_current_object() -> StaticBody3D:
	return current_object


func _input(event):
	# @TODO: disallow clicks when player hasn't moved a piece
	if Input.is_action_just_pressed("lmb"):
		if get_current_object():
			print(get_current_object())
			return
		else:
			pass
			
			print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!! emitting player clicked signal")
			emit_signal("click_signal")
