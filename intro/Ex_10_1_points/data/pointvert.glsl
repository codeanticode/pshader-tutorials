uniform mat4 projection;
uniform mat4 modelview;

attribute vec4 position;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;

void main() {
  vec4 pos = modelview * position;
  vec4 clip = projection * pos;
  
  gl_Position = clip + projection * vec4(offset, 0, 0);
 
  vertColor = color;
}