@tool

extends GunToolGui

enum OPTION_TYPES {BUTTONS,SLIDER}

var options

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

#There's different setting types
@export var option_type : OPTION_TYPES = OPTION_TYPES.BUTTONS:
	set(value):
		option_type = value
		if not is_node_ready(): await ready
		match option_type:
			OPTION_TYPES.BUTTONS:
				button_images = button_images
			OPTION_TYPES.SLIDER:
				_free_options()
				var OptionSlider = load("res://assets/guntool/gun tool gui/modes/settings/option_slider.tscn")
				var option_slider = OptionSlider.instantiate()
				%Options.add_child(option_slider)
				option_slider.owner = self
				option_slider.leave.connect(_on_leave)
				options = option_slider
		notify_property_list_changed()

@export var button_images : Array[CompressedTexture2D] = [] :
	set(val):
		button_images = val
		selected_max = button_images.size() -1
		if Engine.is_editor_hint():
			if not is_node_ready():	await ready
			_free_options()
			for button_image in button_images:

				var OptionBox = load("res://assets/guntool/gun tool gui/modes/settings/option_box.tscn")
				var option_box = OptionBox.instantiate()
				if button_image != null:
					option_box.image = button_image
				%Options.add_child(option_box)
				option_box.owner = self

#Option type buttons:
func selected_change() -> void:
	if not is_node_ready():
		await ready

	match option_type:
		OPTION_TYPES.BUTTONS:
			var i : int = 0
			for option in %Options.get_children():
				if(i == selected):
					option.active = true
				else : option.active = false
				i+=1

#Option type slider:
@export var slider_max : int :
	set(val):
		slider_max = val
		#if not is_node_ready(): await ready
		#var slider = %Options.get_child(0)
		#slider.slider_max = val

#Enables/Disables Exports in editor
func _validate_property(property: Dictionary) -> void:
	if (property.name in ["button_selected","button_images"] and option_type != OPTION_TYPES.BUTTONS):
		property.usage = PROPERTY_USAGE_NO_EDITOR	
	elif (property.name in ["slider_max"] and option_type != OPTION_TYPES.SLIDER):
		property.usage = PROPERTY_USAGE_NO_EDITOR	

func _free_options() -> void:
	# clears options row
	if not is_node_ready():	await ready
	for c in %Options.get_children(): c.queue_free()

func trigger() -> void:
	super.trigger()

	match option_type:
		OPTION_TYPES.BUTTONS:
			selected += 1
		OPTION_TYPES.SLIDER:
			pass

func button() -> void:
	super.button()
	_leave()

func can_enter() -> bool:
	match option_type:
		OPTION_TYPES.SLIDER:
			return true
	return false
