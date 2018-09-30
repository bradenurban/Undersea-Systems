//global Variable
int guiWidth = 1680;
int guiHeight = 1050;


//contributed Libraries

//GUI classes
import controlP5.*;
ControlP5 PaneView_GUI;
//ControlP5 PaneMission_GUI;

//Fwd Camera
import ipcapture.*;
IPCapture fwdCam;


//MQTT
import mqtt.*;
MQTTClient subseaClient;


//For popup windows
import static javax.swing.JOptionPane.*;
// Docs for input dialog: https://docs.oracle.com/javase/8/docs/api/javax/swing/JOptionPane.html
// https://docs.oracle.com/javase/tutorial/uiswing/components/dialog.html


//declare classes
PaneView PaneView1 =                   new PaneView();
Compass Compass1 =                     new Compass((guiWidth-1082-50), (guiHeight-722-200), 1082, 722);
ArtificalHorrizon ArtificalHorrizon1 = new ArtificalHorrizon((guiWidth-1082-50), (guiHeight-722-200), 1082, 722);
Depth Depth1 =                         new Depth((guiWidth-1082-50), (guiHeight-722-200), 1082, 722);
PaneMission PaneMission1 =             new PaneMission(0, 0, 547, 128);

void setup() {
  //Setup Canvas
  size(1680, 1050);
  background(50);
  smooth();

  PaneView_GUI = new ControlP5(this);
  fwdCam = new IPCapture(this, "http://169.254.51.218:9090/stream/video.mjpeg", "", "");

  //Setup camera pane
  PaneView1.initialSetup((guiWidth-1082-50), (guiHeight-722-200), 1082, 722);
  //Pane View

  //Setup Mission Pane
  PaneMission1.initialSetup();

  //subseaClient = new MQTTClient(this);
  //subseaClient.connect("mqtt://try:try@broker.shiftr.io", "processing");
}

void draw() {
  PaneView1.update();
  PaneMission1.update();
 
}





void log_folderSelected(File selection) {
  if (selection == null) {println("Window was closed or the user hit cancel.");} 
  else {println("User selected " + selection.getAbsolutePath());}
}// End Folder Selected  

void target_folderSelected(File selection) {
  if (selection == null) {println("Window was closed or the user hit cancel.");} 
  else {println("User selected " + selection.getAbsolutePath());}
}// End Folder Selected  

void waypoints_folderSelected(File selection) {
  if (selection == null) {println("Window was closed or the user hit cancel.");} 
  else {println("User selected " + selection.getAbsolutePath());}
}// End Folder Selected
