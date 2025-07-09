#include "collisions.h"

bool CheckCollisionPointCube(glm::vec4 model_coord, SceneObject two) {
  // Verifica colisao em tres dimensoes
  return (model_coord.x >= two.bbox_min.x && model_coord.x <= two.bbox_max.x) &&
         (0.5 >= two.bbox_min.y && 0.5 <= two.bbox_max.y) &&
         (model_coord.z >= two.bbox_min.z && model_coord.z <= two.bbox_max.z);
}

bool CheckCollisionPointBall(glm::vec4 model_coord, SceneObject two) {
  // Verifica colisao em tres dimensoes
  return (model_coord.x >= two.bbox_min.x && model_coord.x <= two.bbox_max.x) &&
         (0.5 >= two.bbox_min.y && 0.5 <= two.bbox_max.y) &&
         (model_coord.z >= two.bbox_min.z && model_coord.z <= two.bbox_max.z);
}

bool CheckCollisionCubeCube(SceneObject one, SceneObject two) {
  return (
      one.bbox_min.x <= two.bbox_max.x && one.bbox_max.x >= two.bbox_min.x &&
      one.bbox_min.y <= two.bbox_max.y && one.bbox_max.y >= two.bbox_min.y &&
      one.bbox_min.z <= two.bbox_max.z && one.bbox_max.z >= two.bbox_min.x);
}

bool CheckCollisionCubeBall(SceneObject one, glm::vec4 model_coord,
                            float radius) {
  // get box closest point to sphere center by clamping
  const float x =
      std::max(one.bbox_min.x, std::min(model_coord.x, one.bbox_max.x));
  const float y =
      std::max(one.bbox_min.y, std::min(model_coord.y, one.bbox_max.y));
  const float z =
      std::max(one.bbox_min.z, std::min(model_coord.z, one.bbox_max.z));

  // this is the same as isPointInsideSphere
  const float distance = std::sqrt((x - model_coord.x) * (x - model_coord.x) +
                                   (y - model_coord.y) * (y - model_coord.y) +
                                   (z - model_coord.z) * (z - model_coord.z));

  return distance < radius;
}
