uniform mat4 transform;
uniform vec4 viewport;

attribute vec4 position;
attribute vec4 color;
attribute vec4 direction;

varying vec2 center;
varying vec2 normal;
varying vec4 vertColor;
  
vec3 clipToWindow(vec4 clip, vec4 viewport) {
  vec3 dclip = clip.xyz / clip.w;
  vec2 xypos = (dclip.xy + vec2(1.0, 1.0)) * 0.5 * viewport.zw;
  return vec3(xypos, dclip.z * 0.5 + 0.5);
}
  
void main() {
  vec4 clip0 = transform * position;
  vec4 clip1 = clip0 + transform * vec4(direction.xyz, 0);
  float thickness = direction.w;
  
  vec3 win0 = clipToWindow(clip0, viewport); 
  vec3 win1 = clipToWindow(clip1, viewport); 
  vec2 tangent = win1.xy - win0.xy;
    
  normal = normalize(vec2(-tangent.y, tangent.x));
  vec2 offset = normal * thickness;
  gl_Position.xy = clip0.xy + offset.xy;
  gl_Position.zw = clip0.zw;
  vertColor = color;  
  
  center = (win0.xy + win1.xy) / 2.0;
}