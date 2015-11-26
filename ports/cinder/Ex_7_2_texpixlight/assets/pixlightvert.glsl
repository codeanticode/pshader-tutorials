#version 150

uniform mat4 ciModelView;
uniform mat4 ciModelViewProjection;
uniform mat3 ciNormalMatrix;
uniform mat4 textureMatrix;

uniform vec4 lightPosition;

in vec4	ciPosition;
in vec3	ciNormal;
in vec4	ciColor;
in vec2	ciTexCoord0;

out vec4 vertColor;
out vec3 ecNormal;
out vec3 lightDir;
out vec4 vertTexCoord;

void main() {
  gl_Position = ciModelViewProjection * ciPosition;
  vec3 ecVertex = vec3(ciModelView * ciPosition);  

  ecNormal = normalize(ciNormalMatrix * ciNormal);
  lightDir = normalize(lightPosition.xyz - ecVertex); 
  vertColor = ciColor;

  vertTexCoord = textureMatrix * vec4(ciTexCoord0, 0, 1);
}