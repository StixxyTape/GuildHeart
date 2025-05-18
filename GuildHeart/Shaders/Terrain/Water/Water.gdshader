shader_type canvas_item;

uniform float noiseResolution;
uniform float screenReflectionOffset;

uniform sampler2D noise : filter_nearest, repeat_enable;
uniform sampler2D noise2 : filter_nearest, repeat_enable;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest_mipmap;

void fragment() {
	vec2 uv = SCREEN_UV;
    float y = 1.0 - uv.y;
	y += screenReflectionOffset;
    COLOR = vec4(texture(SCREEN_TEXTURE, vec2(uv.x, y)));
	COLOR.a -= (UV.y / 100.0);

	float noiseColourThing = 2.5;
	vec2 noiseUV = UV;
	noiseUV.y += (0.125);
	noiseUV.y = round(noiseUV.y * 4.0);
	noiseUV.y = round(noiseUV.y * 2.0);

	float speedOffset = 1.0;

	speedOffset = ((noiseUV.y + 128.0) / 128.0 / 4.0);

	vec4 noiseText = mix(
		texture(noise, (1.0/(noiseResolution / 4.0)) * noiseUV + vec2((TIME * speedOffset * 8.0 * (1.0/(noiseResolution / 4.0))), 0)),
		texture(noise2, (1.0/(noiseResolution / 4.0)) * noiseUV + vec2((TIME * speedOffset * 8.0 * (1.0/(noiseResolution / 4.0))))),
		0.03);

	if (noiseText.r < 0.5){
		//noiseText.r = 0.5;
	}

	noiseText.r = round((noiseText.r - 0.1) * noiseColourThing) / noiseColourThing;
	if (noiseText.r > 0.7){
		noiseText.r *= 4.0;
	}
	noiseText.g = noiseText.r;
	noiseText.b = noiseText.r;


	COLOR = mix(COLOR, noiseText, 0.1);

	float colourThing = 20.0;

	COLOR.r = round(COLOR.r * colourThing) / colourThing;
	COLOR.g = (round(COLOR.g * colourThing) / colourThing);
	COLOR.b = (round(COLOR.b * colourThing) / colourThing);

	COLOR.b -= (UV.y / 256.0);

}
