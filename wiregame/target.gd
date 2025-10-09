# Attach to your IK target Node3D
extends Node3D

@export var amplitude: float = 2.0   # meters (± from center)
@export var speed: float = 1.5       # radians per second
@onready var ik: SkeletonIK3D = $"../wire_connector/Armature_003/Skeleton3D/SkeletonIK3D"

var _center: Vector3
var _t: float = 0.0

func _ready() -> void:
	_center = global_position
	ik.active = true
	print(ik.is_running())
	
	#ik.target_node = "."
	#ik.override_pose = true
	ik.start()
	print(ik.is_running())

func _process(delta: float) -> void:
	_t += delta * speed
	global_position.z = _center.z + amplitude * sin(_t)
