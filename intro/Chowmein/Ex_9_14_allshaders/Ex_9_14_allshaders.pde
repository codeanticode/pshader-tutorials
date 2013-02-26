// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/

float canSize = 60;
PImage label;
PShape can;
PShape cap;
float angle;

PShader selShader;
boolean useLight;
boolean useTexture;

PShader colorShader;
PShader lightShader;
PShader texShader;
PShader texlightShader;
PShader pixlightShader;
PShader texlightxShader;
PShader bwShader;
PShader edgesShader;
PShader embossShader;

void setup() {
  size(480, 480, P3D);  
  label = loadImage("lachoy.jpg");
  can = createCan(canSize, 2 * canSize, 32, label);
  cap = createCap(canSize, 32);
  
  colorShader = loadShader("colorfrag.glsl", "colorvert.glsl");
  lightShader = loadShader("lightfrag.glsl", "lightvert.glsl");  
  texShader = loadShader("texfrag.glsl", "texvert.glsl");
  
  texlightShader = loadShader("texlightfrag.glsl", "texlightvert.glsl");
  pixlightShader = loadShader("pixlightfrag.glsl", "pixlightvert.glsl");
  texlightxShader = loadShader("pixlightxfrag.glsl", "pixlightxvert.glsl");
  
  bwShader = loadShader("bwfrag.glsl");
  edgesShader = loadShader("edgesfrag.glsl");
  embossShader = loadShader("embossfrag.glsl");
  
  selShader = texlightShader;
  useLight = true;
  useTexture = true;
  println("Vertex lights, texture shading");  
}

void draw() {    
  background(0);
  
  float x = 1.88 * canSize;
  float y = 2 * canSize;
  int n = 0;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      drawCan(x, y, angle);       
      x += 2 * canSize + 8;
      n++;
    } 
    x = 1.88 * canSize;
    y += 2 * canSize + 5; 
  } 

  angle += 0.01;
}

void drawCan( float centerx, float centery, float rotAngle) {
  pushMatrix();
  
  if (useLight) {
    pointLight(255, 255, 255, centerx, centery, 200);
  }    
  shader(selShader);  
    
  translate(centerx, centery, 65);
  rotateY(rotAngle);
  if (useTexture) {
    can.setTexture(label);
  } else {
    can.setTexture(null);
  }
  shape(can);
  noLights();
    
  resetShader();  
    
  pushMatrix();
  translate(0, canSize - 5, 0);  
  shape(cap);
  popMatrix();

  pushMatrix();
  translate(0, -canSize + 5, 0);  
  shape(cap);
  popMatrix();
  
  popMatrix();
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}

PShape createCap(float r, int detail) {
  PShape sh = createShape();
  sh.beginShape(TRIANGLE_FAN);
  sh.noStroke();
  sh.fill(128);
  sh.vertex(0, 0, 0);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    sh.vertex(x * r, 0, z * r);
  }  
  sh.endShape();
  return sh;  
}

void keyPressed() {
  if (key == '1') {
    println("No lights, no texture shading");
    selShader = colorShader;
    useLight = false;
    useTexture = false;        
  } else if (key == '2') {
    println("Vertex lights, no texture shading");
    selShader = lightShader;
    useLight = true;
    useTexture = false;    
  } else if (key == '3') {
    println("No lights, texture shading");
    selShader = texShader;
    useLight = false;
    useTexture = true;     
  } else if (key == '4') {
    println("Vertex lights, texture shading");
    selShader = texlightShader;
    useLight = true;
    useTexture = true;    
  } else if (key == '5') {
    println("Pixel lights, no texture shading");
    selShader = pixlightShader;
    useLight = true;
    useTexture = false; 
  } else if (key == '6') {
    println("Pixel lights, texture shading");
    selShader = texlightxShader;
    useLight = true;
    useTexture = true;      
  } else if (key == '7') {
    println("Black&white texture filtering");
    selShader = bwShader;
    useLight = false;
    useTexture = true;    
  } else if (key == '8') {
    println("Edge detection filtering");
    selShader = edgesShader;
    useLight = false;
    useTexture = true;    
  } else if (key == '9') {
    println("Emboss filtering");
    selShader = embossShader;
    useLight = false;
    useTexture = true;     
  }
}
