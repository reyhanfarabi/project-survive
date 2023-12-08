shader_type canvas_item;

uniform bool is_damage_taken = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (is_damage_taken) {
		COLOR.r = 1.0;
		COLOR.g = 1.0;
		COLOR.b = 1.0;
	}
}
