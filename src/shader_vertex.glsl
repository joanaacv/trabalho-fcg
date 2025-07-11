#version 330 core

layout (location = 0) in vec4 model_coefficients;
layout (location = 1) in vec4 normal_coefficients;
layout (location = 2) in vec2 texture_coefficients;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Adicione o uniform para o modo de shading
uniform int shading_mode; // 0 = Phong, 1 = Gouraud

// Parâmetros de iluminação (exemplo, ajuste conforme seu código)
uniform vec4 light_position;
uniform vec4 camera_position;
uniform int light_mode; // 0 = difusa (Lambert), 1 = Blinn-Phong

out vec4 position_world;
out vec4 position_model;
out vec4 normal;
out vec2 texcoords;
out vec4 gouraud_color; // Cor calculada para Gouraud

void main()
{
    gl_Position = projection * view * model * model_coefficients;

    position_world = model * model_coefficients;
    position_model = model_coefficients;
    normal = inverse(transpose(model)) * normal_coefficients;
    normal.w = 0.0;
    texcoords = texture_coefficients;

    // Cálculo Gouraud (iluminação por vértice)
    if (shading_mode == 1) {
        vec3 n = normalize(normal.xyz);
        vec3 l = normalize((light_position - position_world).xyz);
        vec3 v = normalize((camera_position - position_world).xyz);
        vec3 r = reflect(-l, n);

        float ambient = 0.2;
        float diff = max(dot(n, l), 0.0);
        float spec = pow(max(dot(r, v), 0.0), 32.0);

        if (light_mode == 1) { // Blinn-Phong
            vec3 h = normalize(l + v);
            spec = pow(max(dot(n, h), 0.0), 32.0);
        }

        gouraud_color = vec4(vec3(ambient + diff + spec), 1.0);
    }
}
