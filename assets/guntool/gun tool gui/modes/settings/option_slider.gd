@tool
extends GunToolGui

@export var active : bool = false :
	set (_active):
		active = _active
		if not is_node_ready():	await ready
		if(active): %Invert.visible = true
		else: %Invert.visible = false

@export var slider_max : int:
	set(val):
		slider_max = val
		selected_max = val
		if not is_node_ready(): await ready
		%Slider.max_value = slider_max
		
func selected_change() -> void:
	%Slider.value = selected

func scroll(val) -> void:
	selected = clamp(selected+val ,0,selected_max)
	
func trigger() -> void:
	_leave()
	
func button() -> void:
	_leave()
