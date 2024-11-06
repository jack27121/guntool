extends Node3D

@onready var camera := $CameraViewport/BoneAttachment3DHandle/GunToolCamera
@onready var raycast := $CameraViewport/BoneAttachment3DHandle/GunToolRayCast

@export_category("settings")
@export_subgroup("Gui color")
@export var gui_colors : Array[Color] = [Color.CHOCOLATE]
@export var gui_color : int = 0:
	set(val):
		gui_color = val
		%GunToolGui.get_node("Gui").material.set_shader_parameter(
				"color_uniform",gui_colors[gui_color])
				
@export var brightness : int = 10:
	set(val):
		brightness = val
		var color = Color.BLACK;
		color.a = lerp(0.9,0.0,brightness/10.0)
		%GunToolGui.get_node("Brightness").color = color

@export var safety : bool :
	set(val):
		safety = val as bool
		
@export var battery_saving : bool :
	set(val):
		battery_saving = val as bool
		
@export var burst_fire : BurstFire :
	set(val):
		burst_fire = val as BurstFire

#var screen_viewport : SubViewport
#var camera_viewport : SubViewport
#var camera_feed : TextureRect
#var highlighting : Node2D

enum BurstFire {
	SINGLE, BURST, RAPID
}

var bullet_impact = preload("res://assets/bullet_impact.tscn")
#preloads sounds
var snd_shoot = preload("res://assets/sounds/guntool/pistol-shot.wav")
var snd_scroll = preload("res://assets/sounds/guntool/snd_scroll-06.ogg")

#gun interactions and animation
func button() -> void:
	%AnimationTree.set("parameters/Buttons/transition_request","interact1")
	%GunToolGui.button();
	
func trigger() -> void:
	%AnimationTree.set("parameters/Buttons/transition_request","interact2")
	%GunToolGui.trigger();

func scroll(val : float) -> void:
	#%Audio.stream = snd_scroll
	#%Audio.play()
	#animate scroll wheel bone
	var bone_rotation : Basis = Basis(%Skeleton3D.get_bone_pose_rotation(1))
	bone_rotation = bone_rotation.rotated(bone_rotation * Vector3(0,1,0),(PI/32.0) * val)
	%Skeleton3D.set_bone_pose_rotation(1, Quaternion(bone_rotation))
	%GunToolGui.scroll(val);
	
func move_speed(speed : float) -> void:
	var blend_pos = %AnimationTree.get("parameters/Moving/blend_position")
	blend_pos = move_toward(blend_pos,speed,0.1)
	%AnimationTree.set("parameters/Moving/blend_position",blend_pos)

func sound_play(sound : AudioStream):
	%Audio.stream = sound
	%Audio.play()

func shoot() -> void:
	if(safety):
		pass
		#sound_play(snd_ui)
	else:
		sound_play(snd_shoot)
		
		%AnimationTree.set("parameters/Buttons/transition_request","shoot")
		var b = bullet_impact.instantiate()
		get_tree().root.add_child(b)
		b.global_position = raycast.get_collision_point()
		var normal = raycast.get_collision_normal()
		b.look_at(b.global_transform.origin + normal, Vector3.UP)
		if normal != Vector3.UP and normal != Vector3.DOWN:
			b.rotate_object_local(Vector3(1,0,0),90)
	
	
