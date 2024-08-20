//shader_type spatial;
shader_type canvas_item;

float dist(vec2 p0, vec2 pf){
	return sqrt((pf.x - p0.x) * (pf.x - p0.x) + (pf.y - p0.y) * (pf.y - p0.y));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float d = dist(vec2(1,1) * 0.5, UV) * 160.0 * 0.003;
	COLOR.rgb = mix(vec3(0.95, 0.97, 0.98), vec3(0.0, 0.0, 0.0), d);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
