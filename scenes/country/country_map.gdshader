shader_type canvas_item;

uniform bool pulsing_active = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a < 0.5) discard;
	if (pulsing_active) {
		COLOR = vec4(COLOR.r + abs(sin(TIME * 2.0)), COLOR.g + abs(sin(TIME * 2.0)), COLOR.b + abs(sin(TIME * 2.0)), 0.5);
	} else {
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, 0.5);
	}
}