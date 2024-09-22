@tool
extends Node3D

@export var color : Color = Color.GRAY:
	set(value):
		color = value
		if Engine.is_editor_hint():
			set_color(color)
		
		
func _ready():
	set_color(color)
		
func set_color(new_color : Color):
	$StaticBody3D/MeshInstance3D.material_override.albedo_color = new_color
