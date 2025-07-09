#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform vec3 Kd_uniform;
uniform vec3 Ka_uniform;
uniform vec3 Ks_uniform;

uniform int material_uses_texture;

// Identificador que define qual objeto está sendo desenhado no momento
#define PLANE 0
#define CAT 1
#define SPHERE 2
#define SOFA1 3
#define SOFA2 4
#define SOFA3 5
#define RUG 6
#define WALL 7

#define SEAT1 11
#define SEAT2 12


uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;
uniform sampler2D TextureImage4;
uniform sampler2D TextureImage5;
uniform sampler2D TextureImage6;
uniform sampler2D TextureImage7;
uniform sampler2D TextureImage8;


// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(1.0,1.0,0.0,0.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;

    // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
    vec3 Kd0 = texture(TextureImage0, vec2(U,V)).rgb;
    // Obtemos o kd_diffuso do material do objeto
    vec3 Kd1 = Kd_uniform;
    // Equação de Iluminação
    float lambert = max(0,dot(n,l));

    if ( object_id == PLANE )
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;
        color.rgb = texture(TextureImage0, vec2(U,V)).rgb * (lambert + 0.1);
    }
    else if (object_id == WALL) {
        float repeat = 4.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage7, tiled_coords); // wall.jpg
    }
    else if (object_id == CAT) {
        color = texture(TextureImage1, texcoords);
    }
    else if (object_id == 11) { // SEAT1
        float repeat = 4.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage4, tiled_coords); // flat-lay-fabric-texture-background
    }
    else if (object_id == 12) { // SEAT2
        float repeat = 4.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage5, tiled_coords); // red-handmade-paper-texture-background
    }
    else if (object_id == SOFA1) {
        float repeat = 6.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage2, tiled_coords); // textura 1.jpg
    }
    else if (object_id == SOFA2) {
        float repeat = 6.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage3, tiled_coords); // textura 2.jpg
    }
    else if (object_id == SOFA3) {
        float repeat = 6.0;
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage4, tiled_coords); // textura 3.jpg
    }
    else if (object_id == RUG) {
        float repeat = 8.0; 
        vec2 tiled_coords = fract(texcoords * repeat);
        color = texture(TextureImage6, tiled_coords);
    }
    else if (object_id == SPHERE){
        // PREENCHA AQUI as coordenadas de textura da esfera, computadas com
        // projeção esférica EM COORDENADAS DO MODELO. Utilize como referência
        // o slides 134-150 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // A esfera que define a projeção deve estar centrada na posição
        // "bbox_center" definida abaixo.

        // Você deve utilizar:
        //   função 'length( )' : comprimento Euclidiano de um vetor
        //   função 'atan( , )' : arcotangente. Veja https://en.wikipedia.org/wiki/Atan2.
        //   função 'asin( )'   : seno inverso.
        //   constante M_PI
        //   variável position_model

        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        float raio = 1.0;

        // Normalizando a posição do modelo para a superfície da esfera
        vec4 p_linha = bbox_center + (raio * ((position_model - bbox_center) / length(position_model - bbox_center)));
        vec4 vetor_p = p_linha - bbox_center;

        // Calculando os ângulos esféricos
        float tetha = atan(vetor_p.x,vetor_p.z);
        float phi = asin(vetor_p.y / raio);

        // Calculando as coordenadas do mapeamento para a textura
        U = (tetha + M_PI) / (2*M_PI);
        V = (phi + M_PI_2) / M_PI;
        color = texture(TextureImage8, vec2(U,V));
    }

    // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
    // necessário:
    // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
    //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
    //      glEnable(GL_BLEND);
    //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
    //    todos os objetos opacos; e
    // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
    //    suas distâncias para a câmera (desenhando primeiro objetos
    //    transparentes que estão mais longe da câmera).
    // Alpha default = 1 = 100% opaco = 0% transparente
    color.a = 1;

    // Cor final com correção gamma, considerando monitor sRGB.
    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
} 

