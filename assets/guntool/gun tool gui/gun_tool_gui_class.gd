@tool

class_name GunToolGui
extends Node

signal leave

#if active_child is not null
#interactions gets propogated down to the activechild
@export var active_child : GunToolGui = null

@export var selected : int = 0 :
	set(val):
		selected = val
		if(selected > selected_max): selected = 0
		if(selected < 0): selected = selected_max
		selected_change()

var selected_max : int = 1

func button() -> void:
	if(active_child != null):
		active_child.button()
		return

func trigger() -> void:
	if(active_child != null):
		active_child.trigger()
		return

func scroll(val : int) -> void:
	if(active_child != null):
		active_child.scroll(val)
		return
	else:
		selected+=val

func _leave() -> void:
	leave.emit()

func _on_leave() -> void:
	active_child = null

func selected_change():
	pass
