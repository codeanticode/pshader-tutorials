#version 150

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 normalMatrix;
uniform mat4 textureMatrix;

uniform vec4 lightPosition;

uniform vec4 globalColor;

in vec4 position;
in vec4 normal;
in vec2 texcoord;

out vec4 vertColor;
out vec3 ecNormal;
out vec3 lightDir;
out vec4 vertTexCoord;

void main() {
  gl_Position = modelViewProjectionMatrix * position;
  vec3 ecVertex = vec3(modelViewMatrix * position);  
  
  ecNormal = normalize(mat3(normalMatrix) * normal.xyz); 
  lightDir = normalize(lightPosition.xyz - ecVertex);  
  vertColor = globalColor;  

  vertTexCoord = textureMatrix * vec4(texcoord, 0.0, 1.0); 
}