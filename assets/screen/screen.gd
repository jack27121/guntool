@tool
extends Node3D
@export var framerate : int = 12:
	set(val):
		framerate = val
		%CameraFeed.framerate = val
@export var camera_viewport : SubViewport:
	set(val):
		camera_viewport = val
		%CameraFeed.camera_viewport = val
@export var signal_loss : float = 0.125:
	set(val):
		signal_loss = val
		%CameraFeed.signal_loss = val
