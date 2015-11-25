#version 150

uniform mat4 modelViewProjectionMatrix;
uniform mat4 normalMatrix;
uniform vec3 lightNormal;

uniform vec4 globalColor;

in vec4 position;
in vec4 normal;

out vec4 vertColor;
out vec3 vertNormal;
out vec3 vertLightDir;

void main() {
  gl_Position = modelViewProjectionMatrix * position;    
  vertNormal = normalize(mat3(normalMatrix) * normal.xyz);
  vertColor = globalColor;
  vertLightDir = -lightNormal;
}