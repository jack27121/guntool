extends Control

signal shoot

@export var camera_viewport_main : SubViewport
@export var camera_main : Camera3D

#The stacks lets you easily back out of ui
var gui_stack : Array[GunToolGui]
var camera : Camera3D

func _ready() -> void:
	camera_reset()
	gui_stack = [%SideMenu]
	
func trigger() -> void:
	gui_stack.back().trigger()
	
func button() -> void:
	gui_stack.back().button()
	
func scroll(val : int) -> void:
	gui_stack.back().scroll(val)

func camera_reset() -> void:
	%CameraFeed.camera_viewport = camera_viewport_main
	%CameraFeed.framerate = 12
	camera = camera_main

func _shoot() -> void:
	shoot.emit()
