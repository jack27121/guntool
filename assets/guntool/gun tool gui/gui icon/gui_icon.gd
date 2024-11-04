extends TextureRect
var button = preload("res://assets/guntool/gun tool gui/gui icon/guntool gui button.png")
var button_active = preload("res://assets/guntool/gun tool gui/gui icon/guntool gui button active.png")

@export var active : bool = false:
	set(_active):
		active = _active
		update()
		
@export var icon : Texture2D:
	set(_icon):
		icon = _icon
		update()

@export var icon_active : Texture2D:
	set(_icon_active):
		icon_active = _icon_active
		update()		

func update() -> void:
	await RenderingServer.frame_post_draw
	if(active == true):
		texture = button_active
		%Icon.texture = icon_active
	else:
		texture = button
		%Icon.texture = icon
	
