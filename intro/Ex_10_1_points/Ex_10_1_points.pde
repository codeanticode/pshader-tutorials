PShader pointShader;

void setup() {
  size(640, 360, P3D);
  
  pointShader = loadShader("pointfrag.glsl", "pointvert.glsl");
  
  stroke(255);
  strokeWeight(50);
  
  background(0);
}

void draw() {  
  shader(pointShader, POINTS);
  if (mousePressed) {   
    point(mouseX, mouseY);
  }  
}

