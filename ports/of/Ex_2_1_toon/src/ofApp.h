#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

	public:
		void setup();
		void draw();
    
        ofCamera cam;
        ofShader shader;
        ofVec3f lightDir;
};
