class Pane_Statusbar {

  int pane_x;
  int pane_y;
  int pane_W;
  int pane_H;
  int center_x;
  int center_y;
  int zero_y;
  int zero_x;
  int end_y;
  int end_x;

  color textColor = #0AE300;
  color background = #323232;
  color accent = #002D5A;
  color button_text = #E5E5E5;

  CameraCan FwdCamera = new CameraCan();
  ControlCan CtrCan = new ControlCan();
  BatteryCan BatCan = new BatteryCan();
  
  Widgits StatusBar_Widgits = new Widgits();
  
  Accordion FC_accordion;
  Accordion CT_accordion;

  Pane_Statusbar() {
  }

  void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y;
    zero_x = pane_x;
    end_y = temp_pane_y;
    end_x = temp_pane_x;

    //Camera Can Setup
    FwdCamera.initialSetup(zero_x, zero_y, pane_W/4, pane_H);
    CtrCan.initialSetup(zero_x+pane_W/4, zero_y, pane_W/2, pane_H);
    BatCan.initialSetup(zero_x+pane_W/4+pane_W/2, zero_y, pane_W/4, pane_H);
  } // end initialUpdate

  StringDict update(StringDict Status, FloatDict Attitude) {
    Status = FwdCamera.update(Status);
    Status = CtrCan.update(Status, Attitude);  
    BatCan.update();

    return Status;
  }//end string dist

  class CameraCan {
    int CC_pane_x;
    int CC_pane_y;
    int CC_pane_W;
    int CC_pane_H;
    int CC_center_x;
    int CC_center_y;
    int CC_zero_y;
    int CC_zero_x;
    int CC_end_y;
    int CC_end_x;

    CameraCan() {
    }
    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      CC_pane_x= temp_pane_x;
      CC_pane_y= temp_pane_y;
      CC_pane_W= temp_pane_W;
      CC_pane_H= temp_pane_H;
      CC_center_x = CC_pane_x+(CC_pane_W/2);
      CC_center_y = CC_pane_y+(CC_pane_H/2);
      CC_zero_y = CC_pane_y;
      CC_zero_x = CC_pane_x;
      CC_end_y = temp_pane_y+temp_pane_H;
      CC_end_x = temp_pane_x+temp_pane_W;

      Group FC_ControlGroup = Pane_GUI.addGroup("Controller")
        .setBackgroundColor(color(0, 64))
        .setBackgroundHeight(150);

      Pane_GUI.addButton("Power")
        .setValue(0)
        .setPosition(10, 10)
        .setSize(50, 20)
        .moveTo(FC_ControlGroup)
        .plugTo( this, "CameraPower")
        .updateSize();


      Pane_GUI.addButton("Connect")
        .setValue(0)
        .setPosition(10, 50)
        .setSize(50, 20)
        .moveTo(FC_ControlGroup)
        .plugTo( this, "CameraConnection")
        .updateSize();

      Pane_GUI.addButton("Disconnect")
        .setValue(0)
        .setPosition(70, 50)
        .setSize(50, 20)
        .moveTo(FC_ControlGroup)
        .plugTo( this, "CameraExit")
        .updateSize();  


      FC_accordion = Pane_GUI.addAccordion("acc")
        .setPosition(CC_zero_x+1, CC_end_y-10)
        .setWidth(CC_pane_W-2)
        .addItem(FC_ControlGroup)
        //.addItem(g2)
        //.addItem(g3)
        ;
      FC_accordion.close(0, 1, 2);
      FC_accordion.setCollapseMode(Accordion.MULTI);
    } 

    StringDict update(StringDict Status) {
      fill(0);
      stroke(0);
      rect(CC_zero_x, CC_zero_y+20, CC_pane_W, CC_pane_H-20);

      pushStyle();
      noFill();
      stroke(0);
      rect(CC_zero_x, CC_zero_y+20, CC_pane_W, CC_pane_H-20);
      popStyle();

      fill(accent);
      rect(CC_zero_x, CC_zero_y, CC_pane_W, 20);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(18);
      textAlign(CENTER, CENTER);
      text("FORWARD CAMERA CAN", CC_center_x, CC_zero_y+6);

      //Temperature Gauges
      StatusBar_Widgits.linear_gauge(CC_zero_x+250, CC_zero_y+70, "Valid", 100, 150, 0, 120, "Deg F", "CPU T");
      StatusBar_Widgits.linear_gauge(CC_zero_x+210, CC_zero_y+70, "Invalid", 80, 150, 0, 120, "Deg F", "Amb T");
      StatusBar_Widgits.linear_gauge(CC_zero_x+170, CC_zero_y+70, "Valid", int(Status.get("FC_Usage_CPU")), 100, 0, 80, "%", "CPU %");
      StatusBar_Widgits.dot_gauge(CC_zero_x+290, CC_center_y-10, "Valid", "Good", "Leak");
      StatusBar_Widgits.dot_gauge(CC_zero_x+290, CC_center_y+37, "Valid", "Caution", "Comm's");

      pushStyle();
      rectMode(CORNER);
      stroke(#00FF00);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(12);
      textAlign(CORNER, CENTER);
      fill(#00FF00);
      noFill();

      text("MQTT STATE:", CC_zero_x+1, CC_zero_y+27);
      text(""+Status.get("FC_State_MQTT"), CC_zero_x+83, CC_zero_y+27);
      rect(CC_zero_x+80, CC_zero_y+23, 65, 15);

      text("LOG STATE:", CC_zero_x+1, CC_zero_y+45);
      text(""+Status.get("FC_State_LOG"), CC_zero_x+83, CC_zero_y+45);
      rect(CC_zero_x+80, CC_zero_y+41, 65, 15);

      text("CAMERA:", CC_zero_x+1, CC_zero_y+63);
      text(""+Status.get("FC_State_CAMERA"), CC_zero_x+83, CC_zero_y+63);
      rect(CC_zero_x+80, CC_zero_y+59, 65, 15);

      text("MODE: ", CC_zero_x+1, CC_zero_y+81);
      text(""+Status.get("FC_Mode"), CC_zero_x+83, CC_zero_y+81);
      rect(CC_zero_x+80, CC_zero_y+77, 65, 15);

      popStyle();
      return Status;
    }

    void CameraConnection() {
      VC_Client.publish("USS/TS/VC/FwdCamControl", "CamStart");
      fwdCam.start(); 
      Status.set("FwdCamState", "On");
      println("started camera");
    }//end cameraConnection

    void CameraExit() {
      VC_Client.publish("USS/TS/VC/FwdCamControl", "CamEnd");
      delay(2);
      fwdCam.stop();
      Status.set("FwdCamState", "Off");
      println("Ended camera");
    }//end cameraConnection
  }

//----------------------------------------------------------------------------------
//Control Can-----------------------------------------------------------------------
//----------------------------------------------------------------------------------
  class ControlCan {
    int CT_pane_x;
    int CT_pane_y;
    int CT_pane_W;
    int CT_pane_H;
    int CT_center_x;
    int CT_center_y;
    int CT_zero_y;
    int CT_zero_x;
    int CT_end_y;
    int CT_end_x;  
    
    int[] imuStatus;
    
    ControlCan() {
    }
    
    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      CT_pane_x= temp_pane_x;
      CT_pane_y= temp_pane_y;
      CT_pane_W= temp_pane_W;
      CT_pane_H= temp_pane_H;
      CT_center_x = CT_pane_x+(CT_pane_W/2);
      CT_center_y = CT_pane_y+(CT_pane_H/2);
      CT_zero_y = CT_pane_y;
      CT_zero_x = CT_pane_x;
      CT_end_y = temp_pane_y;
      CT_end_x = temp_pane_x;


      Group CT_ControlGroup = Pane_GUI.addGroup("CT_Controller")
        .setBackgroundColor(color(0, 64))
        .setBackgroundHeight(150);

      Pane_GUI.addButton("CT_Power")
        .setValue(0)
        .setPosition(10, 10)
        .setSize(50, 20)
        .moveTo(CT_ControlGroup)
        .plugTo( this, "CameraPower")
        .updateSize();

      Pane_GUI.addButton("CT_Connect")
        .setValue(0)
        .setPosition(10, 50)
        .setSize(50, 20)
        .moveTo(CT_ControlGroup)
        .plugTo( this, "CameraConnection")
        .updateSize();

      Pane_GUI.addButton("CT_Disconnect")
        .setValue(0)
        .setPosition(70, 50)
        .setSize(50, 20)
        .moveTo(CT_ControlGroup)
        .plugTo( this, "CameraExit")
        .updateSize();  


      CT_accordion = Pane_GUI.addAccordion("CT_acc")
        .setPosition(CT_zero_x+1, CT_end_y-10)
        .setWidth(CT_pane_W-2)
        .addItem(CT_ControlGroup)

        ;
      CT_accordion.close(0, 1, 2);
      CT_accordion.setCollapseMode(Accordion.MULTI);
    } 

    StringDict update(StringDict Status, FloatDict Attitude) {
      fill(0);
      stroke(0);
      rect(CT_zero_x, CT_zero_y+20, CT_pane_W, CT_pane_H-20);

      pushStyle();
      noFill();
      stroke(0);
      rect(CT_zero_x, CT_zero_y+20, CT_pane_W, CT_pane_H-20);
      popStyle();

      fill(accent);
      rect(CT_zero_x, CT_zero_y, CT_pane_W, 20);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(18);
      textAlign(CENTER, CENTER);
      text("CONTROL CAMERA CAN", CT_center_x, CT_zero_y+6);

      //Temperature Gauges
      StatusBar_Widgits.linear_gauge(CT_zero_x+250, CT_zero_y+70, "Valid", 100, 150, 0, 120, "Deg F", "CPU T");
      StatusBar_Widgits.linear_gauge(CT_zero_x+210, CT_zero_y+70, "Invalid", 80, 150, 0, 120, "Deg F", "Amb T");
      StatusBar_Widgits.linear_gauge(CT_zero_x+170, CT_zero_y+70, "Valid", int(Status.get("CC_Usage_CPU")), 100, 0, 80, "%", "CPU %");
      
      StatusBar_Widgits.dot_gauge(CT_zero_x+290, CT_center_y-10, "Valid", "Good", "Leak");
      StatusBar_Widgits.dot_gauge(CT_zero_x+290, CT_center_y+37, "Valid", "Caution", "Comm's");
      
      //for
      
      StatusBar_Widgits.dot_gauge(CT_zero_x+330, CT_center_y-10, "Valid", "Good", "SysCal");
      StatusBar_Widgits.dot_gauge(CT_zero_x+330, CT_center_y+37, "Valid", "Caution", "AclCal");
      StatusBar_Widgits.dot_gauge(CT_zero_x+410, CT_center_y-10, "Valid", "Good", "GyrCal");

      pushStyle();
      rectMode(CORNER);
      stroke(#00FF00);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(12);
      textAlign(CORNER, CENTER);
      fill(#00FF00);
      noFill();

      text("MQTT STATE:", CT_zero_x+1, CT_zero_y+27);
      text(""+Status.get("CC_State_MQTT"), CT_zero_x+83, CT_zero_y+27);
      rect(CT_zero_x+80, CT_zero_y+23, 65, 15);

      text("LOG STATE:", CT_zero_x+1, CT_zero_y+45);
      text(""+Status.get("CC_State_LOG"), CT_zero_x+83, CT_zero_y+45);
      rect(CT_zero_x+80, CT_zero_y+41, 65, 15);

      text("SERIAL:", CT_zero_x+1, CT_zero_y+63);
      text(""+Status.get("CC_State_SERIAL"), CT_zero_x+83, CT_zero_y+63);
      rect(CT_zero_x+80, CT_zero_y+59, 65, 15);

      text("MODE: ", CT_zero_x+1, CT_zero_y+81);
      text(""+Status.get("CC_Mode"), CT_zero_x+83, CT_zero_y+81);
      rect(CT_zero_x+80, CT_zero_y+77, 65, 15);

      popStyle();
      return Status;
    }
  }

//--------------------------------------------------------------------------------

  class BatteryCan {
    int CB_pane_x;
    int CB_pane_y;
    int CB_pane_W;
    int CB_pane_H;
    int CB_center_x;
    int CB_center_y;
    int CB_zero_y;
    int CB_zero_x;
    int CB_end_y;
    int CB_end_x;

    BatteryCan() {
    }

    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      CB_pane_x= temp_pane_x;
      CB_pane_y= temp_pane_y;
      CB_pane_W= temp_pane_W;
      CB_pane_H= temp_pane_H;
      CB_center_x = CB_pane_x+(CB_pane_W/2);
      CB_center_y = CB_pane_y+(CB_pane_H/2);
      CB_zero_y = CB_pane_y;
      CB_zero_x = CB_pane_x;
      CB_end_y = temp_pane_y;
      CB_end_x = temp_pane_x;


      //Connection Button
    } // end initialUpdate


    void update() {
      fill(background);
      rect(CB_zero_x, CB_zero_y, CB_pane_W, CB_pane_H);

      fill(accent);
      rect(CB_zero_x, CB_zero_y, CB_pane_W, 20);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(18);
      textAlign(CENTER, CENTER);
      text("BATTERY CAN", CB_center_x, CB_zero_y+6);
    }
  }
}//end class
