#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    
    shader.load("shaders/pixlightxvert.glsl", "shaders/pixlightxfrag.glsl");
    cam.setupPerspective();
    
    ofFill();
    ofSetColor(255);
    
    ofDisableArbTex(); // Enables use of GL_TEXTURE_2D textures
    label.load("lachoy.jpg");
    can = createCan(100, 200, 32, label);

    pointLight.set(0, ofGetHeight()/2, -100);
    
    ofEnableDepthTest();
}

//--------------------------------------------------------------
void ofApp::update(){
    angle += 0.01;
}

//--------------------------------------------------------------
void ofApp::draw(){
    cam.begin();
    shader.begin();
    label.bind();

    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    ofMatrix4x4 mv = ofGetCurrentMatrix(OF_MATRIX_MODELVIEW);
    ofVec3f lightPos = ofMatrix4x4::transform3x3(mv, pointLight);
    shader.setUniform4f("lightPosition", lightPos.x, lightPos.y, lightPos.z, 1);

    ofRotateY(ofRadToDeg(angle));

    mv = ofGetCurrentMatrix(OF_MATRIX_MODELVIEW);
    ofMatrix4x4 normMat = ofMatrix4x4::getTransposedOf(mv.getInverse());
    shader.setUniformMatrix4f("normalMatrix", normMat);
    
    can.draw();
    
    label.unbind();
    shader.end();
    cam.end();
}

ofMesh ofApp::createCan(float r, float h, int detail, ofImage label) {
    ofMesh mesh;
    ofCylinderPrimitive* cylinder = new ofCylinderPrimitive(r, h, detail, 1, 2, false);
    cylinder->mapTexCoordsFromTexture(label.getTexture());
    mesh = cylinder->getMesh();
    return mesh;
}
