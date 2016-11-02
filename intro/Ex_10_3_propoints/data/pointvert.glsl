uniform mat4 projection;
uniform mat4 transform;
 
attribute vec4 position;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;
varying vec2 center;
varying vec2 pos;

void main() {
  vec4 clip = transform * position;
  gl_Position = clip + projection * vec4(offset, 0, 0);
  
  vertColor = color;
  center = clip.xy;
  pos = offset;
}