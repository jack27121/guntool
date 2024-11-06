@tool

extends GunToolGuiBase

@onready var options := %OptionList.get_children()
@onready var scroll := %Scroll

func _ready() -> void:
	selected_max = options.size() -1
	set_active()
	
func _button() -> void:
	sound_play(snd_cancel)
	exit()

func _trigger() -> void:
	var option = options[selected]
	option._trigger()

func _scroll(val : int) -> void:
	super._scroll(val)
	sound_play(snd_option)
	scroll.scroll_vertical = max(selected-2,0) * 50
		
	set_active()

func set_active() -> void:
	if(options.size() > 0):
		for option in options:
			option.active = false
		options[selected].active = true
