@tool

class_name GunToolGuiOption
extends GunToolGuiBase

@export var active : bool = false:
	set(val):
		active = val
		if not option_bar: await ready
		option_bar.get_node("%Active").visible = active
		
@export var display_text : String = "text":
	set(val):
		display_text = val
		if not option_bar: await ready
		option_bar.get_node("%Text").text = display_text

@export var option_var : String = ""

@onready var option_bar = $OptionBar
@onready var options = option_bar.get_node("%Options")

func _clear_options() -> void:
	# clears options row
	if not options: await ready
	for c in options.get_children():
		c.queue_free()
		options.remove_child(c)
		
func option_changed() -> void:
	if not guntool : await ready
	if option_var != "":
		guntool.set(option_var,selected)
