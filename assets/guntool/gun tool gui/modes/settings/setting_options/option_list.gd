@tool
extends GunToolGuiOption

@onready var text := %ListText

@export var text_list : Array[String] :
	set(val):
		text_list = val
		selected_max = text_list.size() -1

func _ready() -> void:
	selected = selected

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
	selected -= val

func _on_entered() -> void:
	%Invert.visible = true

func _on_exited() -> void:
	%Invert.visible = false

func _on_selected() -> void:
	if not text: await ready
	text.text = text_list[selected]
	option_changed()
