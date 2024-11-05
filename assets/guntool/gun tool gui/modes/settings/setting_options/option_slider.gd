@tool
extends GunToolGui

signal setting_changed(val : int)

@export var active : bool = false :
	set (_active):
		active = _active
		if not is_node_ready():	await ready
		if(active): %Invert.visible = true
		else: %Invert.visible = false

func _ready() -> void:
	super._ready()

func _on_selected() -> void:
	if not is_node_ready():	await ready
	%Slider.value = selected
	
func _on_selected_max() -> void:
	if not is_node_ready():	await ready
	%Slider.max_value = selected_max
	
func on_entered():
	super.on_entered()
	active = true
	
func on_exited():
	super.on_exited()
	active = false

func scroll(val) -> void:
	selected = clamp(selected-val ,0,selected_max)
	setting_changed.emit(selected)
	
func trigger() -> void:
	exit()
	
func button() -> void:
	exit()
