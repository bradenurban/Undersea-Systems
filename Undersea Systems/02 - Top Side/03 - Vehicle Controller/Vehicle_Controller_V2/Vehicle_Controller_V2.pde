//global Variable
int[] GUI_Size = {1842, 1057};
int[] Pane_View_Size = {1280, 800};
int[] Pane_Waypoint_Size = {(GUI_Size[0]-Pane_View_Size[0]), GUI_Size[1]-((GUI_Size[1]-Pane_View_Size[1])/2)};
int[] Pane_Mission_Size = {Pane_Waypoint_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };
int[] Pane_Statusbar_Size = {Pane_View_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };
int[] Pane_Console_Size = {Pane_View_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };

int temp;

StringDict Status;

//contributed Libraries

//GUI classes
import controlP5.*;
ControlP5 Pane_GUI;

//Fwd Camera
import ipcapture.*;
IPCapture fwdCam;

//MQTT
import mqtt.*;
MQTTClient VC_Client;


//For popup windows
import static javax.swing.JOptionPane.*;
// Docs for input dialog: https://docs.oracle.com/javase/8/docs/api/javax/swing/JOptionPane.html
// https://docs.oracle.com/javase/tutorial/uiswing/components/dialog.html




//declare classes
Pane_Console Pane_Console1 = new Pane_Console();
Pane_Mission Pane_Mission1 = new Pane_Mission();
Pane_Statusbar Pane_Statusbar1 = new Pane_Statusbar();
Pane_View Pane_View1 = new Pane_View();
Pane_Waypoint Pane_Waypoint1 = new Pane_Waypoint();


void setup() {
  //Setup Canvas
  size(displayWidth, displayWidth);
  surface.setResizable(true);
  background(50);
  smooth();


  Pane_GUI = new ControlP5(this);

  Status = new StringDict();
  Status.set("FwdCamState","Off");
  Status.set("Target","TEST1");
  Status.set("TargetHeading","150");  
  Status.set("CurrentHeading","235");
  Status.set("HeadingMode","MANUAL");


  //Setup Panse
  Pane_Console1.initialSetup((GUI_Size[0]-Pane_Console_Size[0]), 
    ((GUI_Size[1]-Pane_View_Size[1])/2 + (Pane_View_Size[1])+1), 
    Pane_Console_Size[0], 
    Pane_Console_Size[1]);
  
  Pane_Mission1.initialSetup(0, 0, 
    Pane_Mission_Size[0], 
    Pane_Mission_Size[1]);
    
  Pane_Statusbar1.initialSetup(Pane_Mission_Size[0], 0, 
    Pane_Statusbar_Size[0], 
    Pane_Statusbar_Size[1]);

  Pane_View1.initialSetup((GUI_Size[0]-Pane_View_Size[0]), 
    ((GUI_Size[1]-Pane_View_Size[1])/2), 
    Pane_View_Size[0], 
    Pane_View_Size[1]);

  Pane_Waypoint1.initialSetup(0, ((GUI_Size[1]-Pane_View_Size[1])/2), 
    Pane_Waypoint_Size[0], 
    Pane_Waypoint_Size[1]);

  //MQTT
  VC_Client = new MQTTClient(this);
  VC_Client.connect("mqtt://192.168.1.74:1883", "VC");
  VC_Client.subscribe("USS/SS/#");
  VC_Client.publish("USS/TS/VC", "Started");
  
  //Camera
  fwdCam = new IPCapture(this, "http://169.254.51.218:9090/stream/video.mjpeg", "", "");
}

void draw() {
  
  temp = CompassSim(int(Status.get("CurrentHeading")));
  
  Status.set("CurrentHeading",str(temp));
  Status = Pane_Console1.update(Status);
  Status = Pane_Mission1.update(Status);
  Status = Pane_Statusbar1.update(Status);
  Status = Pane_View1.update(Status);
  Status = Pane_Waypoint1.update(Status);
}


void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}


void log_folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}// End Folder Selected  

void target_folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}// End Folder Selected  

void waypoints_folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}// End Folder Selected


int CompassSim(int adj){
  adj = int(adj * random(.9999,1.001));
  return adj;
}
