extends Node2D

@export var max_dist : float = 100
@export var camera : Camera3D

var highlights : Array
var active_highlight
var active_position : Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	
	# gets all highlights and checks if they're close enough and not obstructed
	var new_highlights : Array
	highlights = get_tree().get_nodes_in_group("Highlight")
	
	for highlight : VisibleOnScreenNotifier3D in highlights:
		var dist : float = camera.global_position.distance_to(highlight.global_position)
		
		var result : Dictionary = Methods.raycast(camera.global_position,highlight.global_position)
		
		if highlight.is_on_screen() && dist <= max_dist && result.is_empty():
			new_highlights.append(highlight)
	highlights = new_highlights
	
	# sets highlight closest to center of screen as active highlight
	var rect_size : Vector2 = get_viewport_rect().size	
	var dist = 1000
	for highlight in highlights :
		var middle = Vector2(rect_size.x/2.0,rect_size.y/2.0)
		var pos = camera.unproject_position(highlight.global_position)

		var new_dist = pos.distance_to(middle)
		if(new_dist < dist):
			dist = new_dist
			active_highlight = highlight
	
	queue_redraw()


func _draw():

	for highlight in highlights:
		var pos = camera.unproject_position(highlight.global_position)
		var s = 20
		var rect = Rect2(pos.x-(s/2.0),pos.y-(s/2.0),s,s)
		draw_rect(rect,Color.RED,false,2)
	
	#draw active highlight
	if(active_highlight):
		var pos = camera.unproject_position(active_highlight.global_position)
		active_position = active_position.move_toward(pos,5)
		var s = 30
		var rect = Rect2(active_position.x-(s/2.0),active_position.y-(s/2.0),s,s)
		draw_rect(rect,Color.YELLOW,false,2)
