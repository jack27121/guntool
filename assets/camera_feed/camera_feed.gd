@tool
extends TextureRect
@export var framerate : int = 12
@export var camera_viewport : SubViewport
@export var signal_loss : float = 0.125:
	set(val):
		signal_loss = val
		%SignalNoise.material.set_shader_parameter(
				"signal_loss",signal_loss)

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
		var image := camera_viewport.get_texture().get_image()
		texture.set_image(image)
		refresh_counter = 0	
