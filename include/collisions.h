#ifndef COLLISIONS_H
#define COLLISIONS_H
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <algorithm>
#include <string>
// Headers das bibliotecas OpenGL
#include <glad/glad.h>  // Criação de contexto OpenGL 3.3
#include <GLFW/glfw3.h> // Criação de janelas do sistema operacional

// Headers da biblioteca GLM: criação de matrizes e vetores.
#include <glm/vec3.hpp>
#include <glm/vec4.hpp>
#include <glm/gtc/type_ptr.hpp>

struct SceneObject {
  std::string name;   // Nome do objeto
  size_t first_index; // Índice do primeiro vértice dentro do vetor indices[]
                      // definido em BuildTrianglesAndAddToVirtualScene()
  size_t num_indices; // Número de índices do objeto dentro do vetor indices[]
                      // definido em BuildTrianglesAndAddToVirtualScene()
  GLenum rendering_mode;         // Modo de rasterização (GL_TRIANGLES,
                                 // GL_TRIANGLE_STRIP, etc.)
  GLuint vertex_array_object_id; // ID do VAO onde estão armazenados os
                                 // atributos do modelo
  glm::vec3 bbox_min;            // Axis-Aligned Bounding Box do objeto
  glm::vec3 bbox_max;
};

// Funcao para colisao tipo cubo-cubo
bool CheckCollisionPointCube(glm::vec4 model_coord, SceneObject two);
// Confere a colisao da bolinha
bool CheckCollisionPointBall(glm::vec4 model_coord, SceneObject two);
bool CheckCollisionCubeCube(SceneObject one, SceneObject two);
bool CheckCollisionCubeBall(SceneObject one, glm::vec4 model_coord,
                            float radius);
#endif // COLLISIONS_H