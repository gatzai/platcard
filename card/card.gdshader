shader_type canvas_item;

uniform float width = 120.0;
uniform float height = 200.0;
uniform float round_fact = 35.0;

float udRoundBox( in vec2 p, in vec2 b, in float r )
{
    return length(max(abs(p)-b+r,0.0))-r;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = vec4(1,1,1, .2);
	vec2 res = vec2(width, height);
    vec2 p = UV * res * 2.0 - res;
    float f = udRoundBox(p, res, round_fact);
    COLOR.a = smoothstep(1.0,0.0,f);  //边缘透明圆角
	
    float edge = udRoundBox(p, res - vec2(8.0), 25.0 );    //白边圆角
	vec3 edge_color = smoothstep(0.0, 1.0, edge) * vec3(0.9);
	//vec3 inner_color = vec3(smoothstep(1.0, 0.0, edge));
	//inner_color *= vec3(UV.x, UV.y, 1.0);
	//COLOR.rgb = edge_color + inner_color;
	COLOR.rgb = texture(TEXTURE, UV).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
