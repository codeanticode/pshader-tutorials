// From cloud textures from 
// Realistic and Fast Cloud Rendering, Niniane Wang
// http://jgt.akpeters.com/papers/Wang04/
// fig. 6

PShader pointShader;
PImage cloud1;
PImage cloud2;
PImage cloud3;

float weight = 100;

void setup() {
  size(640, 360, P3D);
  
  pointShader = loadShader("spritefrag.glsl", "spritevert.glsl");
  pointShader.set("weight", weight);
  cloud1 = loadImage("cloud1.png");
  cloud2 = loadImage("cloud2.png");
  cloud3 = loadImage("cloud3.png");  
  pointShader.set("sprite", cloud1);
    
  strokeWeight(weight);
  strokeCap(SQUARE);
  stroke(255, 70);
  
  background(0);
}

void draw() {  
  shader(pointShader);
  if (mousePressed) {   
    point(mouseX, mouseY);
  }  
}

void mousePressed() {
  if (key == '1') {
    pointShader.set("sprite", cloud1);
  } else if (key == '2') {
    pointShader.set("sprite", cloud2);
  } else if (key == '3') {
    pointShader.set("sprite", cloud3);
  }
}