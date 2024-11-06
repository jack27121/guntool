extends Control

@export var camera_viewport_main : SubViewport
@export var camera_main : Camera3D

@onready var gui_stack := [%SideMenu]

#The stacks lets you easily back out of ui
var camera : Camera3D

func _ready() -> void:
	camera_reset()
	
func trigger() -> void:
	gui_stack.back()._trigger()
	
func button() -> void:
	gui_stack.back()._button()
	
func scroll(val : int) -> void:
	gui_stack.back()._scroll(val)

func camera_reset() -> void:
	%CameraFeed.camera_viewport = camera_viewport_main
	%CameraFeed.framerate = 12
	camera = camera_main
