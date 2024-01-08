shader_type canvas_item;

uniform vec3 sky_color : source_color = vec3( 0.8, 0.8, 0.98 );
uniform vec3 ground_color : source_color = vec3( 0.8, 0.8, 0.98 );
uniform vec3 star_color : source_color = vec3( 0.8, 0.8, 0.98 );

uniform float divide_by = 2.0;

uniform float star_small_density = 0.1;
uniform float star_density = 0.001;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy,vec2(12.9898,78.233)))
	 * 43758.5453123 );
}

void fragment() {
	    vec3 color;

		//float random_value = random(FRAGCOORD.xy);
		if(FRAGCOORD.y < 1.0/SCREEN_PIXEL_SIZE.y/divide_by){
			
			//if (random_value < star_small_density) {
			if (random(FRAGCOORD.xy) < star_small_density) {
			 	color=star_color;
			}else{
			    color = sky_color;
			}

		}else{
			
			color=ground_color;
		}
		//color=bgcolor2;
		COLOR = vec4(color,255);
}