shader_type canvas_item;

uniform float layer_num = 0.0; // Layer number

void fragment() {
    // Original texture color
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Calculate the orange tint based on layer number
    vec4 orange_tint = vec4(1.0, 0.5, 0.0, 1.0); // Orange color
    tex_color.rgb = mix(tex_color.rgb, orange_tint.rgb, clamp((layer_num - 1.0) * 0.1, 0, 1));
	tex_color.a = mix(0, tex_color.a, clamp((layer_num - 1.0) * 0.1, 0, 1));
    
    COLOR = tex_color;
}
