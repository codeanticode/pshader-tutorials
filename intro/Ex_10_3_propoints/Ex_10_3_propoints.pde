// http://glsl.heroku.com/e#4633.5

PShader pointShader;

void setup() {
  size(640, 360, P3D);
  
  pointShader = loadShader("pointfrag.glsl", "pointvert.glsl");  
  pointShader.set("sharpness", 0.9);
  
  strokeCap(SQUARE);
  background(0);  
}

void draw() {
  if (mousePressed) {
    shader(pointShader);
    
    float w = random(5, 50);
    pointShader.set("weight", w);
    strokeWeight(w);
    
    stroke(random(255), random(255), random(255));  
    point(mouseX, mouseY);
  }
}