shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear;

uniform vec2 resolution = vec2(320.0, 180.0);

uniform float noise_amount :hint_range(0.0, 2.0) = 1.03;
uniform float interference_amount :hint_range(0.0, 50.0) = 0.2;
uniform float signal_loss : hint_range(0.0, 1.0) = 0.0;

float random(vec2 uv){
    return fract(cos(uv.x * 83.4827 + uv.y * 92.2842) * 43758.5453123);
}

vec3 fetch_pixel(vec2 uv, vec2 off){
	vec2 pos = floor(uv * resolution + off) / resolution + vec2(0.5) / resolution;

	float noise = 0.0;
	if(noise_amount > 0.0){
		noise = random(pos + fract(TIME)) * noise_amount;
	}

	if(max(abs(pos.x - 0.5), abs(pos.y - 0.5)) > 0.5){
		return vec3(0.0, 0.0, 0.0);
	}

	vec3 clr = texture(SCREEN_TEXTURE , pos, -16.0).rgb;
	clr = mix(clr, vec3(0.0) + noise ,signal_loss);
	return clr;
}

// Distance in emulated pixels to nearest texel.
vec2 Dist(vec2 pos){
	pos = pos * resolution;
	return - ((pos - floor(pos)) - vec2(0.5));
}

// 1D Gaussian.
float Gaus(float pos, float scale){ return exp2(scale * pos * pos); }

// Allow nearest three lines to effect pixel.
vec3 Tri(vec2 pos){
	vec3 clr = fetch_pixel(pos, vec2(0.0));
	return clr;
}

void fragment(){
	vec2 pix = FRAGCOORD.xy;
	vec2 pos = SCREEN_UV;

	float line = 0.0;

	vec2 sq_pix = floor(pos * resolution) / resolution + vec2(0.5) / resolution;
	if(interference_amount > 0.0){
		float interference = random(sq_pix.yy + fract(TIME));
		pos.x += (interference * signal_loss * (interference_amount + line * 6.0)) / resolution.x;
	}

	vec3 clr = Tri(pos);

	COLOR.rgb = clr;
	//COLOR.a = 1.0;
}