extends Node3D

@onready var skeleton_3d: Skeleton3D = $Armature_003/Skeleton3D
@onready var prong: Node3D = $prong
@onready var target: Node3D = $target
@onready var skeleton_ik_3d: SkeletonIK3D = $Armature_003/Skeleton3D/SkeletonIK3D

var bone_name := "Bone.006"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skeleton_ik_3d.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var bone = skeleton_3d.find_bone(bone_name)
	var bpose = skeleton_3d.get_bone_global_pose(bone)
	
	var bone_forward  = (-bpose.basis.z).normalized()
	
	var prong_target = bpose.origin + bone_forward
	prong.position = target.position
	prong.look_at(prong_target, Vector3.UP)
