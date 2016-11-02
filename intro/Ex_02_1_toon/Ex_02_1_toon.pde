PShader toon;

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
  toon = loadShader("frag.glsl", "vert.glsl");
  toon.set("fraction", 1.0);
}

void draw() {
  shader(toon);
  background(0); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  sphere(120);
}
