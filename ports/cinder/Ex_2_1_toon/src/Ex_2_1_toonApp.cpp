#include "cinder/app/App.h"
#include "cinder/app/RendererGl.h"
#include "cinder/gl/gl.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class Ex_2_1_toonApp : public App {
public:
    void setup() override;
    void resize() override;
    void draw() override;
    void mouseMove(MouseEvent event) override;
    
    float               cameraFOV;
    float               cameraZ;
    CameraPersp         mCam;
    gl::BatchRef        mSphere;
    gl::GlslProgRef		mGlsl;
    ivec2				mLastMousePos;
    vec3                lightDir;
};

void Ex_2_1_toonApp::setup() {
    setWindowSize(640, 360);
    cameraFOV = 60;
    cameraZ = 0.125f * getWindowHeight() / tan(0.5f * glm::radians(cameraFOV));
    mCam.lookAt(vec3(0, 0, cameraZ), vec3(0));
    
    mGlsl = gl::GlslProg::create(loadAsset("vert.glsl"), loadAsset("frag.glsl"));
    mSphere = gl::Batch::create(geom::Sphere().radius(30).subdivisions(30), mGlsl);
    
    gl::enableDepthWrite();
    gl::enableDepthRead();
    
    mGlsl->uniform("fraction", 1.0f);
}

void Ex_2_1_toonApp::resize() {
    mCam.setPerspective(60, getWindowAspectRatio(), cameraZ / 10, cameraZ * 10);
}

void Ex_2_1_toonApp::draw() {
    gl::clear(Color(0, 0, 0));
    
    gl::setMatrices(mCam);
    
    float dirY = 1 - (mLastMousePos[1] / float(getWindowHeight()) - 0.5) * 2;
    float dirX = (mLastMousePos[0] / float(getWindowWidth()) - 0.5) * 2;
    lightDir[0] = -dirX;
    lightDir[1] = -dirY;
    lightDir[2] = -1;
    mGlsl->uniform("lightNormal", lightDir);
    
    gl::color(0.8f, 0.8f, 0.8f);
    mSphere->draw();
}

void Ex_2_1_toonApp::mouseMove( MouseEvent event ) {
    mLastMousePos = event.getPos();
}

CINDER_APP( Ex_2_1_toonApp, RendererGl )
