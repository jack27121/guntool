class_name GunToolGui
extends Node

@export var selected : int :
	set(val):
		selected = val
		if(selected > selected_max): selected = 0
		if(selected < 0): selected = selected_max
		_on_selected()

func _on_selected() -> void : pass
	
@export var selected_max : int = 1:
	set(val):
		selected_max = val
		_on_selected_max()

func _on_selected_max() -> void: pass

func _ready() -> void:
	if not Engine.is_editor_hint():
		owner = find_parent("GunToolGui")

func button() -> void:
	pass

func trigger() -> void:
	pass

func scroll(val : int) -> void:
	selected+=val

func exit() -> void:
	owner.gui_stack.pop_back()
	on_exited()
	owner.gui_stack.back().on_entered()

func enter(gui : GunToolGui):
	owner.gui_stack.append(gui)
	gui.on_entered()
	on_exited()
	
func on_entered() -> void : pass
func on_exited()  -> void : pass
