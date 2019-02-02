class ControlPanel {
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
  color safeColor;
  color armedColor;


  ControlPanel() {
  }//end initial calling

  void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y+1;
    zero_x = pane_x+1;
    end_y = temp_pane_y+temp_pane_H ;
    end_x = temp_pane_x+temp_pane_W;

    safeColor = color(#20B400);
    armedColor = color(#D80000);

    Accordion accordion;
    Knob Light1;
    Knob Light2;
    Knob Light3;

    PFont pfont = createFont("Lucida Sans", 12, true); // use true/false for smooth/no-smooth
    ControlFont font = new ControlFont(pfont, 14);

    Pane_GUI.addButton("Arm")
      .setValue(0)
      .setPosition(pane_x+5, pane_y+5)
      .setSize(pane_W-10, 25)
      .setFont(font)
      .plugTo( this, "ArmThruster")
      ;

    //mission parameters------------------------------
    Group Mission = Pane_GUI.addGroup("Mission")
      //.setBackgroundHeight(200)
      .setSize(pane_W-10, 10)
      .setFont(createFont("Lucida Sans", 8, true))
      ;

    Pane_GUI.addTextlabel("MissionName")
      .setText("MISSION: None Loaded")
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(Mission)
      .setPosition(0, 2);
    ;

    Pane_GUI.addButton("Start")
      .setValue(0)
      .setPosition(0, 20)
      .setSize(int(0.5*pane_W-12), 15)
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(Mission)
      .plugTo( this, "ArmThruster")
      ;

    Pane_GUI.addButton("End")
      .setValue(0)
      .setPosition(0.5*pane_W+2, 20)
      .setSize(int(0.5*pane_W-12), 15)
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(Mission)
      .plugTo( this, "ArmThruster")
      ;

    Pane_GUI.addButton("Load Mission")
      .setValue(0)
      .setPosition(0, 37)
      .setSize(int(pane_W-10), 15)
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(Mission)
      .plugTo( this, "ArmThruster")
      ;


    //lights group-------------------------------------
    Group Lights = Pane_GUI.addGroup("Lights")
      .setSize(pane_W-10, 10)
      .setFont(createFont("Lucida Sans", 8, true))
      ;

    Light1 = Pane_GUI.addKnob("Light1")
      .setRange(0, 100)
      .setValue(0)
      .setPosition(2, 10)
      .setRadius(30)
      .setGroup(Lights)
      .setDecimalPrecision(0)
      .setFont(createFont("Lucida Sans", 10, true))
      ;
    Light2 = Pane_GUI.addKnob("Light2")
      .setRange(0, 100)
      .setValue(0)
      .setPosition(66, 10)
      .setRadius(30)
      .setGroup(Lights)
      .setDecimalPrecision(0)
      .setFont(createFont("Lucida Sans", 10, true))
      ;
    Light3 = Pane_GUI.addKnob("Light3")
      .setRange(0, 100)
      .setValue(0)
      .setPosition(130, 10)
      .setRadius(30)
      .setGroup(Lights)
      .setDecimalPrecision(0)
      .setFont(createFont("Lucida Sans", 10, true))
      ;

    //FC group-------------------------------------
    Group FCCan = Pane_GUI.addGroup("FCCan")
      .setSize(pane_W-10, 10)
      .setFont(createFont("Lucida Sans", 8, true))
      .setLabel("Forward Camera Can")
      ;

    Pane_GUI.addTextlabel("Can1_Power")
      .setText("Power")
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(FCCan)
      .setPosition(0, 0);
    ;

    Pane_GUI.addButton("FCPower_Can")
      .setValue(0)
      .setPosition(0, 15)
      .setSize(60, 20)
      .setLabel("Can Power")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(FCCan)
      .plugTo( this, "ArmThruster")
      ;
    Pane_GUI.addButton("FCPower_Computer")
      .setValue(0)
      .setPosition(0, 37)
      .setSize(60, 20)
      .setLabel("Comp Power")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(FCCan)
      .plugTo( this, "ArmThruster")
      ;

    Pane_GUI.addTextlabel("Can1_Camera")
      .setText("Camera")
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(FCCan)
      .setPosition(62, 0);
    ;

    Pane_GUI.addButton("FCCAmera_Conec")
      .setValue(0)
      .setPosition(62, 15)
      .setSize(60, 20)
      .setLabel("Connect")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(FCCan)
      .plugTo( this, "ArmThruster")
      ;
    Pane_GUI.addButton("FCCAmera_Disconec")
      .setValue(0)
      .setPosition(62, 37)
      .setSize(60, 20)
      .setLabel("Disconnect")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(FCCan)
      .plugTo( this, "ArmThruster")
      ;

    Pane_GUI.addSlider("FCServo")
      .setPosition(135, 20)
      .setSize(10, 70)
      .setRange(-100, 100) // values can range from big to small as well
      .setValue(0)
      .setSliderMode(Slider.FLEXIBLE)
      .setGroup(FCCan)
      .setFont(createFont("Lucida Sans", 12, true))
      .setDecimalPrecision(0) 
      .setLabel("Tilt")
      .plugTo( this, "ArmThruster")
      ;
    Pane_GUI.getController("FCServo").getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPaddingX(0);


    //CC group-------------------------------------
    Group CCan = Pane_GUI.addGroup("CCan")
      .setSize(pane_W-10, 10)
      .setFont(createFont("Lucida Sans", 8, true))
      .setLabel("Control Can")
      ;

    Pane_GUI.addTextlabel("Can2_Power")
      .setText("Power")
      .setFont(createFont("Lucida Sans", 12, true))
      .setGroup(CCan)
      .setPosition(0, 0);
    ;

    Pane_GUI.addButton("CCPower_Can")
      .setValue(0)
      .setPosition(0, 15)
      .setSize(60, 19)
      .setLabel("Can Power")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(CCan)
      .plugTo( this, "ArmThruster")
      ;
    Pane_GUI.addButton("CCPower_Computer")
      .setValue(0)
      .setPosition(0, 36)
      .setSize(60, 19)
      .setLabel("Comp Power")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(CCan)
      .plugTo( this, "ArmThruster")
      ;


    Pane_GUI.addButton("CC_IMU")
      .setValue(0)
      .setPosition(0, 57)
      .setSize(60, 19)
      .setLabel("IMU Power")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(CCan)
      .plugTo( this, "ArmThruster")
      ;
    Pane_GUI.addButton("CC_NetworkSwitch")
      .setValue(0)
      .setPosition(0, 78)
      .setSize(60, 19)
      .setLabel("Net Switch")
      .setFont(createFont("Lucida Sans", 8, true))
      .setGroup(CCan)
      .plugTo( this, "ArmThruster")
      ;





    //accordian for everything
    accordion = Pane_GUI.addAccordion("acc")
      .setPosition(pane_x+5, pane_y+35)
      .setSize(pane_W-10, 10)
      .setBackgroundColor(200)
      .setCollapseMode(Accordion.MULTI)
      .addItem(Mission)
      .addItem(FCCan)
      .addItem(CCan)
      .addItem(Lights)
      ;
  }//end initial setup


  StringDict update(StringDict Status, FloatDict Attitude) {  
    pushStyle();
    //initial fill
    fill(0);
    rect(pane_x, pane_y, pane_W, pane_H);

    //mission



    //change color of thruster based on arm status
    switch(Status.get("CC_ThrusterArm")) {
    case "SAFE" : //thrusters are safe
      Pane_GUI.getController("Arm").setColorBackground(safeColor);
      Pane_GUI.getController("Arm").setLabel("SAFE");
      break;

    case "ARMED" :
      Pane_GUI.getController("Arm").setColorBackground(armedColor);
      Pane_GUI.getController("Arm").setLabel("ARMED");
      break;
    }//end switch





    popStyle();
    return Status;
  }//end update

  void ArmThruster() {

    switch(Status.get("CC_ThrusterArm")) {
    case "SAFE" : //thrusters are safe
      VC_Client.publish("USS/TS/VC/ControlCan", "Arm");

      //used for testing----------------
      Status.set("CC_ThrusterArm", "ARMED");
      break;

    case "ARMED" :
      VC_Client.publish("USS/TS/VC/ControlCan", "Safe");

      //used for testing----------------
      Status.set("CC_ThrusterArm", "SAFE");
      break;
    }//end switch
  }//end cameraConnection
}//end class
