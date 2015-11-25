#version 150

uniform sampler2D texMap;

in vec4 vertColor;
in vec3 ecNormal;
in vec3 lightDir;
in vec4 vertTexCoord;

out vec4 fragColor;

void main() {  
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  float intensity = max(0.0, dot(direction, normal));
  vec4 tintColor = vec4(intensity, intensity, intensity, 1) * vertColor;

  fragColor = texture(texMap, vertTexCoord.st) * tintColor;
}