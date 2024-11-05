extends Node3D

var camera : Camera3D
var screen_viewport : SubViewport
var camera_viewport : SubViewport
var camera_feed : TextureRect
var highlighting : Node2D
var sub_viewport_container: SubViewportContainer
var raycast : RayCast3D

var bullet_impact = preload("res://assets/bullet_impact.tscn")

@export_category("settings")
@export var option1 : int = 0:
	set(val):
		option1 = val
		%"test label".text = str(option1)
@export var option2 : int = 5:
	set(val):
		option2 = val
		%"test label2".text = str(option2)
@export var option3 : int = 5

func _ready() -> void:
	sub_viewport_container = $SubViewportContainer
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_ONLY)
	camera = $CameraViewport/BoneAttachment3DHandle/GunToolCamera
	raycast = $gun_tool_skeleton/Skeleton3D/BoneAttachment3DBarrel/Node3D/GunToolRayCast
	
func _process(_delta: float) -> void:
	pass
	
func _exit_tree() -> void:
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_DISABLED)

#gun interactions and animation
func button() -> void:
	%AnimationTree.set("parameters/Buttons/transition_request","interact1")
	%GunToolGui.button();
	
func trigger() -> void:
	%AnimationTree.set("parameters/Buttons/transition_request","interact2")
	%GunToolGui.trigger();

func scroll(val : float) -> void:
	#animate scroll wheel bone
	var bone_rotation : Basis = Basis(%Skeleton3D.get_bone_pose_rotation(1))
	bone_rotation = bone_rotation.rotated(bone_rotation * Vector3(0,1,0),(PI/32.0) * val)
	%Skeleton3D.set_bone_pose_rotation(1, Quaternion(bone_rotation))
	
	%GunToolGui.scroll(val);
	
func move_speed(speed : float) -> void:
	var blend_pos = %AnimationTree.get("parameters/Moving/blend_position")
	blend_pos = move_toward(blend_pos,speed,0.1)
	%AnimationTree.set("parameters/Moving/blend_position",blend_pos)

func _on_gun_tool_gui_shoot() -> void:
	%AnimationTree.set("parameters/Buttons/transition_request","shoot")
	
	var b = bullet_impact.instantiate()
	get_tree().root.add_child(b)
	b.global_position = raycast.get_collision_point()
	var normal = raycast.get_collision_normal()
	b.look_at(b.global_transform.origin + normal, Vector3.UP)
	if normal != Vector3.UP and normal != Vector3.DOWN:
		b.rotate_object_local(Vector3(1,0,0),90)
	
	
