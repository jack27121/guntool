extends Node3D

@export var sub_viewport_container: SubViewportContainer

func _ready() -> void:
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_ONLY)
	
func _exit_tree() -> void:
	sub_viewport_container.set_clip_children_mode(CanvasItem.CLIP_CHILDREN_DISABLED)
