shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
void fragment() {
	COLOR = texture(SCREEN_TEXTURE,SCREEN_UV,0);
	COLOR.rgb = vec3(1,1,1) - COLOR.rgb;

}