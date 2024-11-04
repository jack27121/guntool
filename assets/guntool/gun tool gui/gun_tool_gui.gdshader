shader_type canvas_item;

uniform vec3 color_uniform = vec3(1,1,1);

void fragment() {
	COLOR = texture(TEXTURE,UV);
	COLOR.rgb = color_uniform * COLOR.rgb;
}