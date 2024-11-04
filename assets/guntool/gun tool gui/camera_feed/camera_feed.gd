extends TextureRect
@export var framerate : int = 12
@export var camera_viewport : SubViewport

var refresh_interval : float = 1
var refresh_counter : float = 0

func _ready() -> void:
	refresh_interval = 1.0 / framerate
	
func _process(delta: float) -> void:
	#camera refresh
	refresh_counter += delta
	if refresh_counter >= refresh_interval:
		#update camera screen, to simulate low fps
		await RenderingServer.frame_post_draw
		if camera_viewport != null:
			texture.set_image( camera_viewport.get_texture().get_image() )
		refresh_counter = 0	
	
