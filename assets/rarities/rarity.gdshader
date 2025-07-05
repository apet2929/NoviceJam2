shader_type spatial;


render_mode cull_disabled;

varying float distanceToCam; // distance from cam to center
varying vec4 world_pos;  // of current vertex
varying float vertexToCam; // distance from current vertex to the camera

varying float depth;

const float wave_speed[3] = { 4.0, 1.0, 1.0 };
const float wavelength[3] = { 5.3, 0.8, 2.5 };
const float wave_amp[3] = { 0.1, 0.2, 0.05 };
uniform float aura_padding = 0.5;
uniform vec3 aura_color : source_color;

float sum_of_sines(float theta){
	float sum = 0.0;
	for(int i = 0; i < wave_speed.length(); i++) {
		sum += wave_amp[i] * sin((theta*wavelength[i]) + (TIME*wave_speed[i]));
	}
	return sum;
}

void vertex() {
	depth = distance(CAMERA_POSITION_WORLD, NODE_POSITION_WORLD);
	
	float facing_away = 1.0 - abs(dot(NORMAL, vec3(0.0, 0.0, 1.0)));
	//float facing_away = abs(dot(viewspace_binormal, vec3(0.0, 0.0, 1.0)));
	float theta = atan(VERTEX.y, VERTEX.z); // [-PI, PI]
	float dist_from_center = length(VERTEX);
	float grow_amount = sum_of_sines(theta);
	
	
	VERTEX += (aura_padding + grow_amount) * NORMAL;
}

float circle(vec2 uv){
	return length(uv - vec2(0.5));
}

float weighted_avg(float[2] vals, float[2] weights) {
	float sum = 0.0;
	float totalWeight = 0.0;
	for(int i = 0; i < vals.length(); i++){
		sum += vals[i] * weights[i];
		totalWeight += weights[i];
	}
	return sum / totalWeight;
}

void fragment() {
//	  	  float f1 = dot(VIEW, vec3(0,0,1));
//+       float f2 = length(sin(UV * vec2(25)));
//+       float f = weighted_avg({f1, f2}, {1.0, 0.1});
//+       //rad = (0.01) * (1.0 / FRAGCOORD.z);  //
//+       //f = smoothstep(0.95 * (1.0 - rad), 1, f); // [
//+       ALBEDO = vec3(100.0 * fract(f));

//float rad = 1.0 / pow(depth,0.5);
	float density = 48.0;
	//float density = 50.0 / sqrt(max(depth, 1.0));
	float f1 = dot(VIEW, vec3(0,0,1));
	float rad = 0.05;
	f1 = smoothstep(1.0-rad, 1.0, f1); // 
	float f2 = length(sin(UV * vec2(density)));
	float f = weighted_avg({f1, f2}, {0.0, 1.0});
	vec3 foo = normalize(vec3(cos(TIME), 0, sin(TIME)));
	float d = dot(BINORMAL, foo); 
	float threshold = d;
	f = smoothstep((1.0 - threshold), 1, f);
	float dark_spots = smoothstep(f-0.1, f+0.1, 0.3);
	vec3 dc = vec3(0.3, 0.9, 0.8);
	vec3 dark_colors = vec3(dark_spots * dc);
	ALBEDO = aura_color;
	ALPHA = 0.7;
}

