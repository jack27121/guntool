extends Node3D

@export var framerate : int = 12

var camera : Camera3D
var screen_viewport : SubViewport
var camera_viewport : SubViewport
var camera_feed : TextureRect
var highlighting : Node2D
var sub_viewport_container: SubViewportContainer

var refresh_interval : float = 1
var refresh_counter : float = 0

var highlight_positions : Array

func _ready() -> void:
	SignalBus.connect("_highlight_component",highlight_component)
	
	sub_viewport_container = $SubViewportContainer
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_ONLY)
	
	camera = $CameraViewport/BoneAttachment3DHandle/GunToolCamera
	screen_viewport = $SubViewportContainer/ScreenViewport
	camera_viewport = $CameraViewport
	camera_feed = $SubViewportContainer/ScreenViewport/CanvasLayer/Control/CameraFeed
	highlighting = $SubViewportContainer/ScreenViewport/CanvasLayer/Control/Highlighting
	highlighting.root = self
	
	refresh_interval = 1.0 / framerate
	
func _process(delta: float) -> void:
	refresh_counter += delta
	if refresh_counter >= refresh_interval:
		#update camera screen, to simulate low fps
		await RenderingServer.frame_post_draw
		camera_feed.texture.set_image( camera_viewport.get_texture().get_image() )
		refresh_counter = 0	
		
	await get_tree().process_frame
	highlight_positions.clear()
	
func _exit_tree() -> void:
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_DISABLED)

	
func highlight_component(highlight_pos : Vector3):
	highlight_positions.append( camera.unproject_position(highlight_pos))
	
