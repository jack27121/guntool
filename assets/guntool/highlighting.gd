extends Node2D

@export var texture : Texture2D:
	set(value):
		texture = value
		queue_redraw()

var root : Node3D

func _process(_delta: float) -> void:
	queue_redraw()
	
func _draw():
	for pos in root.highlight_positions:
		var s = 20
		var rect = Rect2(pos.x-(s/2.0),pos.y-(s/2.0),s,s)
		draw_rect(rect,Color.RED,false,2)
		
	
