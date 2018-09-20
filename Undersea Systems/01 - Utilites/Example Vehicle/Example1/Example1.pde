// Example Vehicle

import mqtt.*;
import controlP5.*;

ControlP5 cp5;
MQTTClient client;
int prevTime_health = 0;
int prevTime_alert = 0;
int Ambient_Temp_Value = 0;
boolean Ambient_Temp = false;
int Ambient_Temp_Rate = 1;
int x_pos = 0;
int y_pos = 0;

CameraCan FwdCamera;
String[] FwdCamHealth = new String[2];
String[] FwdCamAlert = new String[2];

//Color Setups       

void setup() {
  //Window
  size(1200,920);
  background(0);
  
  //MQTT
  client = new MQTTClient(this);
  client.connect("mqtt://try:try@broker.shiftr.io", "SubSea_Test", true);
  //client.connect("mqtt://192.168.1.74", "SubSea_Test", true);

  
  //Gui
  cp5 = new ControlP5(this);

  //Can Setup 
  FwdCamera = new CameraCan("FwdCamera", 300, 20, 1);
  FwdCamera.setup_gui();

  delay(500);
  client.subscribe("Subsea/#");
  delay(500);
}

void draw() {

if(FwdCamera.CameraCan_Power == true){
  FwdCamHealth = FwdCamera.health_message();
  FwdCamAlert = FwdCamera.alert_message();
  //prevTime_health = MQTT_Message(FwdCamHealth[0],FwdCamHealth[1],1,prevTime_health);
  prevTime_alert = MQTT_Message(FwdCamAlert[0],FwdCamAlert[1],1,prevTime_alert);
}

}


void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}

int MQTT_Message (String Topic, String Message, int temp_Rate, int prevTime) {
    int Rate;
    Rate = 1000/temp_Rate;
    if((millis()-prevTime) > Rate){
      client.publish(Topic, Message);
      //println(Topic + Message);
      prevTime = millis();
    }
return prevTime ;
}
