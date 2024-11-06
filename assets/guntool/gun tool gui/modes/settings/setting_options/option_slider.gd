@tool
extends GunToolGuiOption

@onready var slider := %Slider

func _trigger() -> void:
	if(gui.gui_stack.back() != owner):
		sound_play(snd_cancel)
		exit()
	else:
		sound_play(snd_ok)
		enter(self)
	
func _button() -> void:
	sound_play(snd_cancel)
	exit()

func _scroll(val : int) -> void:
	sound_play(snd_option)
	var new_selected = selected - val
	selected = clamp(new_selected,0,selected_max)
	
func _on_entered() -> void:
	%Invert.visible = true

func _on_exited() -> void:
	%Invert.visible = false

func _on_selected() -> void:
	if not slider: await ready
	slider.value = selected
	option_changed()

func _on_selected_max() -> void:
	if not slider: await ready
	slider.max_value = selected_max
