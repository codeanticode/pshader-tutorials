#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{
    
public:
    void setup();
    void update();
    void draw();
    
    ofMesh createCan(float r, float h, int detail, ofImage tex);

    ofCamera cam;
    ofShader shader;
    ofVec3f pointLight;
    ofMesh can;
    ofImage label;
    float angle;    
};
