@tool
extends GunToolGui

@onready var guntool : Node3D = self.find_parent("GunTool")

signal setting_changed(setting_name : String, value : int)

enum OPTION_TYPES {BUTTONS,SLIDER}

@export var setting_name : String = "setting_name"

@export var active : bool = false :
	set(_active):
		active = _active
		if not is_node_ready(): await ready
		
		if(active): %Active.visible = true
		else : %Active.visible = false

@export var text : String = "Text" :
	set(val):
		text = val
		if not is_node_ready(): await ready
		%Text.text = val

func _ready() -> void:
	super._ready()
	_type_init()
	selected = selected

#There's different setting types
@export var option_type : OPTION_TYPES = OPTION_TYPES.BUTTONS:
	set(value):
		option_type = value
		if Engine.is_editor_hint():			
			_type_init()
			notify_property_list_changed()

func _type_init():
	match option_type:
		OPTION_TYPES.BUTTONS:
			_button_images_init()
		OPTION_TYPES.SLIDER:
			_free_options()
			var OptionSlider = load("res://assets/guntool/gun tool gui/modes/settings/setting_options/option_slider.tscn")
			var option_slider : GunToolGui = OptionSlider.instantiate()
			%Options.add_child(option_slider)
			option_slider.setting_changed.connect(_on_setting_change)
			if Engine.is_editor_hint():
				option_slider.owner = self
			
func _button_images_init():
	selected_max = button_images.size() -1
			
	_free_options()
	for button_image in button_images:
		var OptionBox = load("res://assets/guntool/gun tool gui/modes/settings/setting_options/option_box.tscn")
		var option_box = OptionBox.instantiate()
		if button_image != null:
			option_box.image = button_image
		if not is_node_ready():	await ready
		%Options.add_child(option_box)
		if Engine.is_editor_hint():
			option_box.owner = self

@export var button_images : Array[CompressedTexture2D] = [] :
	set(val):
		button_images = val
		if Engine.is_editor_hint():
			_button_images_init()

#Option type buttons:
func _on_selected() -> void:
	if not is_node_ready(): await ready
	match option_type:
		OPTION_TYPES.BUTTONS:
			var i : int = 0
			for option in %Options.get_children():
				if(i == selected):
					option.active = true
				else : option.active = false
				i+=1
		OPTION_TYPES.SLIDER:
			%Options.get_child(0).selected = selected
			
func _on_selected_max() -> void:
	if not is_node_ready(): await ready
	match option_type:
		OPTION_TYPES.SLIDER:
			%Options.get_child(0).selected_max = selected_max

#Enables/Disables Exports in editor
func _validate_property(property: Dictionary) -> void:
	if (property.name in ["button_selected","button_images"] and option_type != OPTION_TYPES.BUTTONS):
		property.usage = PROPERTY_USAGE_NO_EDITOR
		
	if (property.name in ["selected_max"] and option_type == OPTION_TYPES.BUTTONS):
		property.usage = PROPERTY_USAGE_NO_EDITOR

func _free_options() -> void:
	# clears options row
	if not is_node_ready(): await ready
	for c in %Options.get_children():
		c.queue_free()
		%Options.remove_child(c)

func trigger() -> void:
	match option_type:
		OPTION_TYPES.BUTTONS:
			selected += 1
			_on_setting_change(selected)
		OPTION_TYPES.SLIDER:
			enter(%Options.get_child(0))

func button() -> void:
	exit()

func _on_setting_change(val : int):
	guntool.set(setting_name, val)
