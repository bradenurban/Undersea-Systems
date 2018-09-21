//global Variable
int guiWidth = 1680;
int guiHeight = 1050;


//contributed Libraries

//GUI classes
import controlP5.*;
ControlP5 cp5;

//Fwd Camera
import ipcapture.*;
IPCapture fwdCam;

//MQTT
import mqtt.*;
MQTTClient subseaClient;





PaneView PaneView1 = new PaneView();


void setup() {
  //Setup Canvas
  size(1680, 1050);
  background(50);
  
  //Setup camera pane
  PaneView1.initialUpdate(859,279,722,482);
  //Pane View
   
  
  
  //fwdCam = new IPCapture(this, "http://169.254.51.218:9090/stream/video.mjpeg", "", "");
  //fwdCam.start();
  
  //subseaClient = new MQTTClient(this);
  //subseaClient.connect("mqtt://try:try@broker.shiftr.io", "processing");
  
}

void draw() {
  //PaneView.update();
  
  
}
  
  
  
  
  
  
  
