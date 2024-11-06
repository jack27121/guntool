class_name GunToolGuiBase
extends Node

@export var selected_max : int = 1:
	set(val):
		selected_max = val
		_on_selected_max()

@export var selected : int :
	set(val):
		selected = val
		if(selected > selected_max): selected = 0
		if(selected < 0): selected = selected_max
		_on_selected()

@onready var gui = find_parent("GunToolGui")
@onready var guntool = find_parent("GunTool")

var snd_cancel = preload("res://assets/sounds/guntool/gui/SND Cancel.mp3")
var snd_option = preload("res://assets/sounds/guntool/gui/SND Option.mp3")
var snd_ng = preload("res://assets/sounds/guntool/gui/SND System Ng.mp3")
var snd_ok = preload("res://assets/sounds/guntool/gui/SND System Ok.mp3")

func _on_selected_max() -> void: pass

func _on_selected() -> void : pass

func sound_play(snd) -> void:
	guntool.sound_play(snd)

func exit() -> void:
	_on_exited()
	gui.gui_stack.pop_back()
	gui.gui_stack.back()._on_entered()

func enter(element : GunToolGuiBase):
	_on_exited()
	gui.gui_stack.append(element)
	element._on_entered()

func _button() -> void: pass

func _trigger() -> void: pass

func _scroll(val : int) -> void:
	selected+=val
	
func _on_entered() -> void : pass
func _on_exited()  -> void : pass
