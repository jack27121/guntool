@tool

extends ColorRect

@export var active : bool = false :
	set (_active):
		active = _active
		if not is_node_ready():	await ready
		if(active): %Invert.visible = true
		else: %Invert.visible = false

@export var image : CompressedTexture2D:
	set(_image):
		await ready
		image = _image
		%OptionTexture.texture = image
