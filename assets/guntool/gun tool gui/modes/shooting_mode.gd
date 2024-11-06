extends GunToolGuiBase

@export var zoom_max : float = 9
@export var zoom_min : float = 39
@export var zoom_step : float = 1.5

func _button() -> void:
	sound_play(snd_cancel)
	exit()

func _trigger() -> void:
	guntool.shoot()

#func scroll(val : int) -> void:
	#pass
	##zoom camera
	##var camera : Camera3D = owner.camera
	##camera.fov += (val * zoom_step);
	##camera.fov = clamp(camera.fov,zoom_max,zoom_min)
	#
