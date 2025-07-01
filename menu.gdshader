shader_type canvas_item;

uniform float shine_width = 0.27;       // thinner beam for sharper shine
uniform float shine_speed = 0.5;       // faster movement
uniform vec4 shine_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec2 uv = UV;

    // Main shine beam (sharp)
    float shine = smoothstep(0.5 - shine_width, 0.5, mod(TIME * shine_speed + uv.x, 1.0));
    shine *= smoothstep(1.0, 0.0, shine);

    // Glow around the shine (softer wider band)
    float glow = smoothstep(0.5 - shine_width*3.0, 0.5 - shine_width*1.5, mod(TIME * shine_speed + uv.x, 1.0));
    glow *= smoothstep(0.5 + shine_width*1.5, 0.5 + shine_width*3.0, mod(TIME * shine_speed + uv.x, 1.0));

    // Combine shine and glow, amplify brightness
    float intensity = max(shine, glow);

    COLOR = texture(TEXTURE, UV) * (1.0 + intensity * shine_color * 3.0);
}
