shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
const float Split = 1.0;

void fragment() {

	vec2 hsplit = SCREEN_PIXEL_SIZE * vec2(1.0,0.0) * Split;
	vec2 vsplit = SCREEN_PIXEL_SIZE * vec2(0.0,1.0) * Split;

	COLOR.r = texture(SCREEN_TEXTURE,SCREEN_UV + hsplit,0).r;
	COLOR.g = texture(SCREEN_TEXTURE,SCREEN_UV + vsplit,0).g;
	COLOR.b = texture(SCREEN_TEXTURE,SCREEN_UV,0).b;
}