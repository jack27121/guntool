@tool
extends GunToolGuiOption

var OptionBox = preload("res://assets/guntool/gun tool gui/modes/settings/setting_options/parts/option_box.tscn")

@export var button_images : Array[CompressedTexture2D] = [] :
	set(val):
		button_images = val

		selected_max = button_images.size() -1
		_clear_options()
		for button_image in button_images:				
			var option_box = OptionBox.instantiate()
			if button_image != null:
				option_box.image = button_image
			if not options:	await ready
			options.add_child(option_box)
			option_box.owner = self
		set_active()

func _on_selected() -> void:
	set_active()
	option_changed()

func set_active() -> void:
	if not options: await ready
	for option in options.get_children():
		option.active = false
	options.get_child(selected).active = true

func _trigger() -> void:
	sound_play(snd_ok)
	selected+=1
