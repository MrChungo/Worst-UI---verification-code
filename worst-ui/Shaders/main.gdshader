shader_type canvas_item;

uniform vec4 tint : source_color = vec4(0.0, 0.0, 0.0, 0.5); // Black with 50% opacity

void fragment() {
    // Read the screen pixels underneath the ColorRect
    vec4 screen_color = texture(TEXTURE, SCREEN_UV);
    
    // Multiply the screen pixels by the tint color
    COLOR = screen_color * tint;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
