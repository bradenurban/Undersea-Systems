//global Variable
int[] GUI_Size = {1842, 1057};
int[] Pane_View_Size = {1280, 800};
int[] Pane_Waypoint_Size = {(GUI_Size[0]-Pane_View_Size[0]), GUI_Size[1]-((GUI_Size[1]-Pane_View_Size[1])/2)};
int[] Pane_Mission_Size = {Pane_Waypoint_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };
int[] Pane_Statusbar_Size = {Pane_View_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };
int[] Pane_Console_Size = {Pane_View_Size[0], (GUI_Size[1]-Pane_View_Size[1])/2 };

int temp;

StringDict Status;
StringDict MQTT;
FloatDict Attitude;

//contributed Libraries
import controlP5.*;//GUI classes
ControlP5 Pane_GUI;

import ipcapture.*;//Fwd Camera
IPCapture fwdCam;

import mqtt.*;//MQTT
MQTTClient VC_Client;

import static javax.swing.JOptionPane.*;//For popup windows
// Docs for input dialog: https://docs.oracle.com/javase/8/docs/api/javax/swing/JOptionPane.html
// https://docs.oracle.com/javase/tutorial/uiswing/components/dialog.html

//declare custom classes
Pane_Console Pane_Console1 =     new Pane_Console();
Pane_Mission Pane_Mission1 =     new Pane_Mission();
Pane_Statusbar Pane_Statusbar1 = new Pane_Statusbar();
Pane_View Pane_View1 =           new Pane_View();
Pane_Gauges Pane_Gauges1 =       new Pane_Gauges();


void setup() {
  //Setup Canvas
  size(displayWidth, displayHeight);
  surface.setResizable(true);
  background(0);
  smooth();
  
  //create instance of gui items
  Pane_GUI = new ControlP5(this);

  //initial population of Status Dictionary
  Status = new StringDict();
  Status.set("FwdCamState","Off");
  Status.set("FwdCam_Health_TempCPU", "67");
  Status.set("Target","TEST1");
  Status.set("TargetHeading","150");  
  Status.set("HeadingMode","MANUAL");
  Status.set("FC_Usage_CPU","0");
  Status.set("CC_Usage_CPU","0");

  //initial population of MQTT string dictionary
  MQTT = new StringDict();
  MQTT.set("USS/SS/#","Initial");

  //initial population of MQTT string dictionary
  Attitude = new FloatDict();
  Attitude.set("Heading",10);
  Attitude.set("Pitch",3);
  Attitude.set("Roll",5);
  Attitude.set("Heave",0);
  Attitude.set("Sway",0);
  Attitude.set("Surge",0);
  Attitude.set("SysCal",0);
  Attitude.set("AclCal",0);
  Attitude.set("GyrCal",0);
  Attitude.set("Depth",10); 

  //Setup Panes
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

  Pane_Gauges1.initialSetup(0, ((GUI_Size[1]-Pane_View_Size[1])/2), 
    Pane_Waypoint_Size[0], 
    Pane_Waypoint_Size[1]);

  //MQTT parameters
  VC_Client = new MQTTClient(this);
  VC_Client.connect("mqtt://192.168.1.74:1883", "VC");
  VC_Client.subscribe("USS/SS/#");
  VC_Client.publish("USS/TS/VC", "Started");
  
  //Camera parameters, Forward Camera
  fwdCam = new IPCapture(this, "http://169.254.51.218:9090/stream/video.mjpeg", "", "");
}

//----------------------------------------------------------------------------------
//Main Draw-------------------------------------------------------------------------
//----------------------------------------------------------------------------------

void draw() {
  
  //update panes--------------------------
  Status = Pane_Console1.update(Status, MQTT, Attitude);
  Status = Pane_Mission1.update(Status);
  Status = Pane_Statusbar1.update(Status, Attitude);
  Status = Pane_View1.update(Status, Attitude);
  Status = Pane_Gauges1.update(Status, Attitude);
  
}

//----------------------------------------------------------------------------------
//begin functions-------------------------------------------------------------------
//----------------------------------------------------------------------------------

void messageReceived(String topic, byte[] payload) {
  String message = new String(payload);
  MQTT = addMessage(topic,message,MQTT);
  if (topic.equals("USS/SS/FwdCam/Health")){
    Status = parseFC_Health(message,Status);
    println("Message: " + topic + " - " + new String(payload));
  }//end if
  if (topic.equals("USS/SS/CtrCan/Health")){
    Status = parseCC_Health(message,Status);
    println("Message: " + topic + " - " + new String(payload));
  }//end if
    if (topic.equals("USS/SS/CtrCan/IMU")){
    Attitude = parseIMU(message,Attitude);
  }//end if
  
  
}//end messageReceived


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



//Parse Health messages to Status dictionary
StringDict parseFC_Health(String message, StringDict Status){
  String[] temp = split(message,',');
   Status.set("FC_Temp_CPU",temp[0]);
   Status.set("FC_Temp_Amb",temp[1]);
   Status.set("FC_Usage_CPU",temp[2]);
   Status.set("FC_State_MQTT",temp[3]);
   Status.set("FC_State_LOG",temp[4]);
   Status.set("FC_State_CAMERA",temp[5]);
   Status.set("FC_Mode",temp[6]);
   Status.set("FC_Leak",temp[7]);
  return Status;
}//end parse function

//Parse Health messages to Status dictionary
StringDict parseCC_Health(String message, StringDict Status){
  String[] temp = split(message,',');
   Status.set("CC_Temp_CPU",temp[0]);
   Status.set("CC_Temp_Amb",temp[1]);
   Status.set("CC_Usage_CPU",temp[2]);
   Status.set("CC_State_MQTT",temp[3]);
   Status.set("CC_State_LOG",temp[4]);
   Status.set("CC_State_SERIAL",temp[5]);
   Status.set("CC_Mode",temp[6]);
   Status.set("CC_Leak",temp[7]);
  return Status;
}//end parse function

//Parse Health messages to Status dictionary
FloatDict parseIMU(String message, FloatDict Attitude){
  String[] temp = split(message,',');
   Attitude.set("Heading",float(temp[0]));
   Attitude.set("Pitch",float(temp[1]));
   Attitude.set("Roll",float(temp[2]));
   Attitude.set("Heave",float(temp[3]));
   Attitude.set("Surge",float(temp[4]));
   Attitude.set("Sway",float(temp[5]));
   Attitude.set("SysCal",float(temp[6]));
   Attitude.set("AclCal",float(temp[7]));
   Attitude.set("GyrCal",float(temp[8]));
  return Attitude;
}//end parse function

StringDict addMessage(String topic, String message, StringDict MQTT){
  MQTT.set(topic,message);
  return MQTT;
}//end add message

int PitchSim(int adj){
  adj = int(0+sin(frameCount*0.002)*10);
  return adj;}

int RollSim(int adj){
  adj = int(0+sin(frameCount*0.003)*5);
  return adj;}
  
int DepthSim(int adj){
  adj = int(60+sin(frameCount*0.0005)*55);
  return adj;}

int CompassSim(int adj){
  adj = int(180+sin(frameCount*0.002)*120);
  return adj;}
