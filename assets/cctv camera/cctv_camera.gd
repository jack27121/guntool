@tool

extends Node3D

@onready var animtree := $AnimationTree

@export_range(-50,50)  var pitch : float = 0 :
	set(val):
		pitch = val
		if not animtree: await ready
		var size = 50
		animtree.set("parameters/pitch/seek_request",(pitch+size)/(size*2))
		
@export_range(-100,100) var yaw : float = 0 :
	set(val):
		yaw = val
		if not animtree: await ready
		var size = 100
		animtree.set("parameters/yaw/seek_request",(yaw+size)/(size*2))

func _ready() -> void:
	pitch = pitch
	yaw = yaw
