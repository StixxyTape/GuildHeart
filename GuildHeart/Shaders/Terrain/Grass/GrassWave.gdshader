shader_type canvas_item;

uniform float windCutoff = 11.0; //8.0
uniform float windStrength = 0.5; //1.0
uniform float windSpeed = 2.0; //1.0
uniform float windDirection = 0.2; //0.5

varying vec2 worldPos;

varying float worldOffset;

void vertex() {
    worldPos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	worldOffset = sin(worldPos.x);
}

void fragment() {

	float xResolution = (1.0 / TEXTURE_PIXEL_SIZE.x);
	float yResolution = (1.0 / TEXTURE_PIXEL_SIZE.y);
	vec2 fixed_uv = UV;

	float windOffset = round(
		((windDirection * TEXTURE_PIXEL_SIZE.x) + windStrength * sin(
			windSpeed * TIME + round((UV.y * yResolution) + 0.5) / yResolution * (worldOffset * 2.0)
			) * TEXTURE_PIXEL_SIZE.x)
 		* (round((1.0 - (fixed_uv.y - (TEXTURE_PIXEL_SIZE.y * windCutoff)))))
		* (round((1.0 - fixed_uv.y) * (yResolution / 4.0) * 2.0))
		* xResolution) / xResolution;

	fixed_uv.x += windOffset;

	vec4 pixel_color = texture(TEXTURE, fixed_uv);

	COLOR = pixel_color;

	COLOR.r += windOffset * 0.15;
	COLOR.g += windOffset * 0.15;
	COLOR.b += windOffset * 0.15;
}
