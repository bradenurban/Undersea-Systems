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
  ControlCan CtrlCan = new ControlCan();
  BatteryCan BatCan = new BatteryCan();

  Pane_Statusbar() {

  }
  //Class Functions--------------------------------------- 
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
    CtrlCan.initialSetup(zero_x+pane_W/4, zero_y, pane_W/2, pane_H);
    BatCan.initialSetup(zero_x+pane_W/4+pane_W/2, zero_y, pane_W/4, pane_H);
    
  } // end initialUpdate

  StringDict update(StringDict Status) {
    Status = FwdCamera.update(Status);
    CtrlCan.update();  
    BatCan.update();
    return Status;
  }

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
      ;
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
      CC_end_y = temp_pane_y;
      CC_end_x = temp_pane_x;

      Pane_GUI.addButton("CameraConnection")
        .setValue(0)
        .setPosition(CC_zero_x+5, CC_center_y-40)
        .setSize(80, 80)
        .setImages(loadImage("Camera_white.png"), loadImage("Camera_Blue.png"), loadImage("Camera_Green.png"))
        .plugTo( this, "CameraConnection")
        .updateSize();

      Pane_GUI.addButton("CameraExit")
        .setValue(0)
        .setPosition(CC_zero_x+5, CC_center_y+12)
        .setSize(80, 80)
        .setImages(loadImage("Camera_exit_white.png"), loadImage("Camera_exit_blue.png"), loadImage("Camera_exit_Green.png"))
        .plugTo( this, "CameraExit")
        .updateSize();       

      Pane_GUI.addButton("Power")
        .setValue(0)
        .setPosition(CC_zero_x+57, CC_center_y-40)
        .setSize(80, 80)
        .setImages(loadImage("Power_White.png"), loadImage("Power_Blue.png"), loadImage("Power_Green.png"))
        .plugTo( this, "CameraPower")
        .updateSize();

      Pane_GUI.addButton("ScreenShot")
        .setValue(0)
        .setPosition(CC_zero_x+57, CC_center_y+12)
        .setSize(80, 80)
        .setImages(loadImage("Power_White.png"), loadImage("Power_Blue.png"), loadImage("Power_Green.png"))
        .plugTo( this, "Screenshot")
        .updateSize();
        
      Pane_GUI.addButton("Query")
        .setValue(0)
        .setPosition(CC_zero_x+109, CC_center_y-40)
        .setSize(80, 80)
        .setImages(loadImage("Power_White.png"), loadImage("Power_Blue.png"), loadImage("Power_Green.png"))
        .plugTo( this, "Screenshot")
        .updateSize();
        
      Pane_GUI.addButton("Record")
        .setValue(0)
        .setPosition(CC_zero_x+109, CC_center_y+12)
        .setSize(80, 80)
        .setImages(loadImage("Power_White.png"), loadImage("Power_Blue.png"), loadImage("Power_Green.png"))
        .plugTo( this, "Screenshot")
        .updateSize();
    
  
} // end initialUpdate

    StringDict update(StringDict Status) {
      fill(background);
      rect(CC_zero_x, CC_zero_y+20, CC_pane_W, CC_pane_H-20);

      fill(accent);
      rect(CC_zero_x, CC_zero_y, CC_pane_W, 20);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(18);
      textAlign(CENTER, CENTER);
      text("FORWARD CAMERA CAN", CC_center_x, CC_zero_y+6);

      //Temperature Gauges
      linear_gauge(CC_zero_x+250, CC_zero_y+75, "Valid", 100, 150, 0, 120, "Deg F", "CPU");
      linear_gauge(CC_zero_x+210, CC_zero_y+75, "Invalid", 80, 150, 0, 120, "Deg F", "Amb");
      dot_gauge(CC_zero_x+290, CC_center_y-10, "Valid", "Good", "Leak");
      dot_gauge(CC_zero_x+290, CC_center_y+40, "Valid", "Caution", "Comm's");

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

    ControlCan() {
      ;
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
    } // end initialUpdate


    void update() {
      fill(background);
      rect(CT_zero_x, CT_zero_y, CT_pane_W, CT_pane_H);

      fill(accent);
      rect(CT_zero_x, CT_zero_y, CT_pane_W, 20);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(18);
      textAlign(CENTER, CENTER);
      text("CONTROL CAN", CT_center_x, CT_zero_y+6);
    }
  }


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
      ;
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


  void linear_gauge(int x_loc, int y_loc, String state, float value, float value_max, float value_min, float value_red, String Units, String Label) {

    int w = 10;
    int h = 65;
    float h_red = map(value_max-value_red, value_min, value_max, 0, h);
    float y_value = map(value_max-value, value_min, value_max, 0, h);

    stroke(0);
    strokeWeight(1);

    fill(0, 255, 0);
    rect(x_loc-(w/2), y_loc-(h/2), w, h);
    fill(255, 0, 0);
    rect(x_loc-(w/2), y_loc-(h/2), w, h_red);

    if (state == "Valid") {
      stroke(255);
      strokeWeight(3);
      line(x_loc-(w/2)-2, y_value+y_loc-(h/2), x_loc+(w/2)+2, y_value+y_loc-(h/2));
    }

    textFont(createFont("Yu Gothic UI Bold", 12));
    fill(textColor);

    //Units text
    textSize(12);
    textAlign(CENTER, CENTER);
    text(Units, x_loc, y_loc+h-25);
    text(Label, x_loc, y_loc - 45);

    //return Stroke Weight back to black and 1
    stroke(0);
    strokeWeight(1);
  }//end linear guage 

  void dot_gauge(int x_loc, int y_loc, String state, String value, String Label) {
    int D = 25;

    stroke(0);
    strokeWeight(1);
    fill(0);
    ellipseMode(CENTER);
    ellipse(x_loc, y_loc, D, D);

    if (state == "Valid") {
      strokeWeight(0);
      if (value == "Good") {
        fill(0, 255, 0);
        ellipse(x_loc, y_loc, D-1, D-1);
      } else if (value == "Caution") {
        fill(255, 255, 0);
        ellipse(x_loc, y_loc, D-1, D-1);
      } else {
        fill(255, 0, 0);
        ellipse(x_loc, y_loc, D-1, D-1);
      }
    } else {
      fill(100, 100, 100);
      ellipse(x_loc, y_loc, D-1, D-1);
    }

    //Units text
    fill(textColor);
    textSize(12);
    textAlign(CENTER, CENTER);
    text(Label, x_loc, y_loc - 25);

    //return Stroke Weight back to black and 1
    stroke(0);
    strokeWeight(1);
  }//end dot gauge
}
