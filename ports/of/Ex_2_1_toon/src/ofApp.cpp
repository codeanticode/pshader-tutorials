#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);

    shader.load("shaders/vert.glsl", "shaders/frag.glsl");
    cam.setupPerspective();
    
    ofFill();
    ofSetColor(204);

    ofEnableDepthTest();
}

//--------------------------------------------------------------
void ofApp::draw(){
    cam.begin();
    shader.begin();
    shader.setUniform1f("fraction", 1.0);

    ofMatrix4x4 mv = ofGetCurrentMatrix(OF_MATRIX_MODELVIEW);
    ofMatrix4x4 normMat = ofMatrix4x4::getTransposedOf(mv.getInverse());
    shader.setUniformMatrix4f("normalMatrix", normMat);
    
    float dirY = (mouseY / float(ofGetHeight()) - 0.5) * 2;
    float dirX = (mouseX / float(ofGetWidth()) - 0.5) * 2;
    lightDir.set(-dirX, -dirY, -1);
    
    ofVec3f lightNorm = ofMatrix4x4::transform3x3(normMat, lightDir);
    lightNorm.normalize();
    shader.setUniform3f("lightNormal", lightNorm.x, lightNorm.y, lightNorm.z);
    
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    ofDrawSphere(0, 0, 120);
    
    shader.end();
    cam.end();
}

