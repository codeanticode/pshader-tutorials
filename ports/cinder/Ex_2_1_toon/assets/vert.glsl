#version 150

uniform mat4 ciModelViewProjection;
uniform mat3 ciNormalMatrix;
uniform vec3 lightNormal;

in vec4	ciPosition;
in vec3	ciNormal;
in vec4	ciColor;

out vec4 vertColor;
out vec3 vertNormal;
out vec3 vertLightDir;

void main() {
  gl_Position = ciModelViewProjection * ciPosition;    
  vertNormal = normalize(ciNormalMatrix * ciNormal);
  vertColor = ciColor;
  vertLightDir = -normalize(ciNormalMatrix * lightNormal);
}