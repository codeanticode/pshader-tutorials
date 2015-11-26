#include "cinder/app/App.h"
#include "cinder/app/RendererGl.h"
#include "cinder/gl/gl.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class Ex_7_2_texpixlightApp : public App {
public:
    void setup() override;
    void resize() override;
    void update() override;
    void draw() override;
    gl::BatchRef createCan(float r, float h, int detail);
    
    float               cameraFOV;
    float               cameraZ;
    CameraPersp         cam;
    gl::BatchRef        can;
    gl::GlslProgRef		shader;
    vec3                pointLight;
    
    gl::Texture2dRef    label;
    float               angle;
};

void Ex_7_2_texpixlightApp::setup() {
    setWindowSize(640, 360);
    cameraFOV = 60;
    cameraZ = 0.125f * getWindowHeight() / tan(0.5f * glm::radians(cameraFOV));
    cam.lookAt(vec3(0, 0, cameraZ), vec3(0));
    
   	auto img = loadImage(loadAsset("lachoy.jpg"));
    label = gl::Texture2d::create(img);
    
    pointLight[0] = 0; pointLight[1] = -getWindowHeight(); pointLight[2] = 0;
    
    shader = gl::GlslProg::create(loadAsset("pixlightvert.glsl"), loadAsset("pixlightfrag.glsl"));
    shader->uniform("texMap", 0);
    can = createCan(100, 200, 32);
    
    gl::enableDepthWrite();
    gl::enableDepthRead();
}

void Ex_7_2_texpixlightApp::resize() {
    cam.setPerspective(60, getWindowAspectRatio(), cameraZ / 10, cameraZ * 10);
}

void Ex_7_2_texpixlightApp::update() {
    angle += 0.01;
}

void Ex_7_2_texpixlightApp::draw() {
    gl::clear(Color(0, 0, 0));
    
    gl::setMatrices(cam);
    gl::ScopedModelMatrix modelScope;
    
    mat4 tm = mat4(1.0);
    tm[1][1] = -1; tm[3][1] = 1;
    shader->uniform("textureMatrix", tm);
    
    mat4 mv = gl::getModelMatrix();
    vec4 lightPos = mv * vec4(pointLight, 1.0f);
    shader->uniform("lightPosition", lightPos);
    
    gl::translate(0, -100, -3 * cameraZ);
    gl::rotate(angle, 0, 1, 0);
    
    gl::color(1, 1, 1);
    gl::ScopedTextureBind tex0(label, 0);
    can->draw();
}

gl::BatchRef Ex_7_2_texpixlightApp::createCan(float r, float h, int detail) {
    return gl::Batch::create(geom::Cylinder().radius(r).height(h).subdivisionsAxis(detail).subdivisionsHeight(1), shader);
}

CINDER_APP( Ex_7_2_texpixlightApp, RendererGl )
