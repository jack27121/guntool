extends Node2D

@export var max_dist : float = 100
@export var highlight_focus_radius : float = 16
@export var highlight_size : float = 12
@export var active_highlight_size : float = 16
@export var highlight_focus_time : float = 1

var camera : Camera3D
var highlights : Array
var active_highlight
var active_pos : Vector2
var middle : Vector2

var cross_size : float = 0

func _ready() -> void:
	#middle = Vector2(%ScreenViewport.size.x/2,%ScreenViewport.size.y/2)
	#camera = %GunToolCamera
	#active_pos = middle
	pass

#func _process(_delta: float) -> void:
	#
	## gets all highlights and checks if they're close enough and not obstructed
	#var new_highlights : Array
	#highlights = get_tree().get_nodes_in_group("Highlight")
	#
	#for highlight : VisibleOnScreenNotifier3D in highlights:
		#var dist : float = camera.global_position.distance_to(highlight.global_position)
		#
		#var result : Dictionary = Methods.raycast(camera.global_position,highlight.global_position)
		#
		#if highlight.is_on_screen() && dist <= max_dist && result.is_empty():
			#new_highlights.append(highlight)
	#highlights = new_highlights
	#
	## sets highlight closest to center of screen as active highlight	
	#var center_dist = 1000
	#active_highlight = null
	#for highlight in highlights :
		#var pos = camera.unproject_position(highlight.global_position)
#
		#var new_center_dist = pos.distance_to(middle)
		#if(new_center_dist <= highlight_focus_radius && new_center_dist < center_dist):
			#center_dist = new_center_dist
			#active_highlight = highlight
			#
	#if(active_highlight != null):	
		#%HighlightLabel.text = active_highlight.get_name()
	#else:
		#%HighlightLabel.text = "Null"
	#
	#queue_redraw()

func _draw():
	var pos : Vector2
	#draw all highlights
	for highlight in highlights:
		pos = camera.unproject_position(highlight.global_position)
		var s = highlight_size
		var rect = Rect2(pos.x-(s/2.0),pos.y-(s/2.0),s,s)
		draw_rect(rect,Color.RED,false,2)
	
	#draw active highlight
	pos = middle
	if(active_highlight != null):
		pos = camera.unproject_position(active_highlight.global_position)
		cross_size = move_toward(cross_size,active_highlight_size,highlight_focus_time)
	else : cross_size = move_toward(cross_size,0,highlight_focus_time)
	
	active_pos = active_pos.move_toward(pos,highlight_focus_time)
	
	#draw lines altering between cross and square shape
	#left
	var pl1 = Vector2(-cross_size,-highlight_size)
	var pl2 = Vector2(-cross_size, highlight_size)
	draw_line(active_pos+pl1,active_pos+pl2,Color.WHITE,1)
	
	#right
	var pr1 = Vector2(cross_size,-highlight_size)
	var pr2 = Vector2(cross_size, highlight_size)
	draw_line(active_pos+pr1,active_pos+pr2,Color.WHITE,1)
	
	#up
	var pu1 = Vector2(-highlight_size,-cross_size)
	var pu2 = Vector2(highlight_size, -cross_size)
	draw_line(active_pos+pu1,active_pos+pu2,Color.WHITE,1)
	
	#down
	var pd1 = Vector2(-highlight_size,cross_size)
	var pd2 = Vector2(highlight_size, cross_size)
	draw_line(active_pos+pd1,active_pos+pd2,Color.WHITE,1)
