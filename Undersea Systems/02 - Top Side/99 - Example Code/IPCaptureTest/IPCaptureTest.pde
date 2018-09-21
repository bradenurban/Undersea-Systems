/* IPCapture sample sketch for Java and Android   *
 *                                                *
 * === IMPORTANT ===                              *
 * In Android mode, Remember to enable            *
 * INTERNET permissions in the                    *
 * Android -> Sketch permissions menu             */

import ipcapture.*;
int W;
int H;
Boolean camState;


IPCapture cam;

void setup() {
  size(1080,720);
  cam = new IPCapture(this, "http://169.254.51.218:9090/stream/video.mjpeg", "", "");
  cam.start();
  W = 1080;
  H = 720;
  camState = false;
  
  // this works as well:
  
  //cam = new IPCapture(this);
  //cam.start("192.168.1.85:8000/stream.mjpg", "", "");
  
  // It is possible to change the MJPEG stream by calling stop()
  // on a running camera, and then start() it with the new
  // url, username and password.
}

void draw() {
  camState = cam.isAlive();
    if (cam.isAvailable()) {
      cam.read();
      image(cam,0,0,W,H);
    }

println(cam.isAlive());
}
