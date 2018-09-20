class CameraCan {
  
  String Name;
  int x_pos;
  int y_pos;
  int w;
  int h;
  int Temp_Topic;
  int Rate;  
  int font;
  int T1;
  int V1;
  int C1;
  boolean CameraCan_Power;
  boolean T1toogle;
  boolean V1toogle;
  boolean C1toogle;
  boolean Leak;
  String Topic;
  
  CameraCan(String tempName, int temp_x_pos, int temp_y_pos, int temp_Rate){
  
    Name = tempName;
    x_pos = temp_x_pos;
    y_pos = temp_y_pos;
    w = 300;
    h = 300 ;  
    
    T1 = 50;
    V1 = 18;
    C1 = 1;
      
}

  void setup_gui() {
    PFont pfont = createFont("Arial",12,true); 
  
      Group g1 = cp5.addGroup("CameraCan Group")
                .setPosition(x_pos,y_pos)
                .setBackgroundColor(color(50,90))
                .setBackgroundHeight(h)
                .setWidth(w)
                //.setFont(pfont)
                .enableCollapse()
                .setLabel(Name);
                
    //Can Power
                cp5.addToggle("CameraCan_Power")
                 .setPosition(30,20)
                 .setSize(50,20)
                 .setValue(false)
                 .setMode(ControlP5.SWITCH)
                 .setFont(pfont)
                 .plugTo( this, "updatePower")
                 .setGroup(g1);
                cp5.getController("CameraCan_Power").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(2);

  
    //Ambient Temp
                cp5.addToggle("CameraCan_Temp")
                 .setPosition(30,80)
                 .setSize(50,20)
                 .setValue(false)
                 .setMode(ControlP5.SWITCH)
                 .setFont(pfont)
                 .plugTo( this, "updateTempToggle")
                 .setGroup(g1); 
              cp5.addSlider("CameraCan_Temp_Value")
                 .setPosition(90,80)
                 .setSize(100,20)
                 .setRange(0,100)
                 .setFont(pfont)
                 .setGroup(g1)
                 .setValue(50)
                 .plugTo( this, "updateTemp")
                 .setLabel("C");  
              cp5.getController("CameraCan_Temp").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(2);
    
    //Voltage 
              cp5.addToggle("CameraCan_Voltage")
                 .setPosition(30,140)
                 .setSize(50,20)
                 .setValue(false)
                 .setMode(ControlP5.SWITCH)
                 .setFont(pfont)
                 .plugTo( this, "updateVoltageToggle")
                 .setGroup(g1);
              cp5.addSlider("CameraCan_Voltage_Value")
                 .setPosition(90,140)
                 .setSize(100,20)
                 .setRange(0,20)
                 .setGroup(g1)
                 .setValue(18)
                 .setFont(pfont)
                 .plugTo( this, "updateVoltage")
                 .setLabel("V");
              cp5.getController("CameraCan_Voltage").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(2);

    //Current 
              cp5.addToggle("CameraCan_Current")
                 .setPosition(30,200)
                 .setSize(50,20)
                 .setValue(false)
                 .setMode(ControlP5.SWITCH)
                 .setFont(pfont)
                 .plugTo( this, "updateCurrenToggle")
                 .setGroup(g1);
              cp5.addSlider("CameraCan_Current_Value")
                 .setPosition(90,200)
                 .setSize(100,20)
                 .setRange(0,5)
                 .setGroup(g1)
                 .setValue(1)
                 .setFont(pfont)
                 .plugTo( this, "updateCurrent")
                 .setLabel("A");
              cp5.getController("CameraCan_Current").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(2); 
  
    //Leak Detect
              cp5.addToggle("CameraCan_Leak")
                 .setPosition(30,260)
                 .setSize(50,20)
                 .setValue(false)
                 .setMode(ControlP5.SWITCH)
                 .setFont(pfont)
                 .plugTo( this, "updateLeak")
                 .setGroup(g1);
              cp5.getController("CameraCan_Leak").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(2);     
  
  }

void updatePower(boolean temp)         { CameraCan_Power = temp; }
void updateTempToggle(boolean temp)    { T1toogle = temp;}
void updateTemp(int temp)              { T1 = temp; }
void updateVoltageToggle(boolean temp) { V1toogle = temp; }
void updateVoltage(int temp)           { V1 = temp; }
void updateCurrenToggle(boolean temp) { C1toogle = temp; }
void updateCurrent(int temp)           { C1 = temp; }
void updateLeak(boolean temp)          { Leak = temp; }
  
String[] health_message() {
  String[] message = new String[2];
  
    //Setup MQTT Message parameters
    String[] Temp_Topic = new String[3];
      Temp_Topic[0] = "Subsea";
      Temp_Topic[1] = Name;
      Temp_Topic[2] = "Health/";
    message[0] = join(Temp_Topic,"/"); 
  
  
  String[] temp_Value = new String[3];
      if (T1toogle == true){
        temp_Value[0] = str(T1);}
      else{temp_Value[0] = str(0);}
        
      if (V1toogle == true){
        temp_Value[1] = str(V1);}
      else{temp_Value[1] = str(0);}        

      if (C1toogle == true){
        temp_Value[2] = str(C1);}
      else{temp_Value[2] = str(0);}  

   message[1] = join(temp_Value,", "); 
return message ;
 }
 
 
 // To Do, create under/over temp/voltage/current 
String[] alert_message() {
  String[] message = new String[2];
  
    //Setup MQTT Message parameters
    String[] Temp_Topic = new String[3];
      Temp_Topic[0] = "Subsea";
      Temp_Topic[1] = Name;
      Temp_Topic[2] = "Alert/";
    message[0] = join(Temp_Topic,"/"); 
  
  
  String[] temp_Value = new String[4];
      if (T1toogle == false){
        temp_Value[0] = str(1);} //Unkonw Temp
      else if(T1>80){
        temp_Value[0] = str(2);} //Over Temp
      else if(T1<10){
        temp_Value[0] = str(3);} //Under Temp
      else{
        temp_Value[0] = str(0);} //Good Temp
        
      if (V1toogle == false){
        temp_Value[1] = str(1);} //Unknown Voltage
      else if(V1>80){
        temp_Value[1] = str(2);} //Over Voltage
      else if(V1<10){
        temp_Value[1] = str(3);} //Under Voltage
      else{
        temp_Value[1] = str(0);} //Good Voltage     

      if (C1toogle == false){
        temp_Value[2] = str(1);} //Unknown Current
      else if(C1>0.8){
        temp_Value[2] = str(2);} //Over Current
      else{
        temp_Value[2] = str(0);} //Good Current
       
      if (Leak == true){
        temp_Value[3] = str(1);}     //Detected Leak
      else{temp_Value[3] = str(0);}  //Good Leak

        
   message[1] = join(temp_Value,", "); 
return message ;
 }
 
 
 
 
 
 
 
 
 
 
}
