class View_Update {
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
  float k;
  float l;
  String[] Letter = new String[4];
  String[] Number= new String[4];
  int WidgitNumber;



  View_Update() {
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

    WidgitNumber = 0;

    Pane_GUI.addButton("Start")
      .setValue(0)
      .setPosition(5, 5)
      .setSize(60, 20)
      //.moveTo(FC_ControlGroup)
      .plugTo( this, "CameraConnection")
      ;
    Pane_GUI.addButton("Stop")
      .setValue(0)
      .setPosition(70, 5)
      .setSize(60, 20)
      //.moveTo(FC_ControlGroup)
      .plugTo( this, "CameraExit")
      ;
    Pane_GUI.addButton("Widigit")
      .setValue(0)
      .setPosition(135, 5)
      .setSize(60, 20)
      //.moveTo(FC_ControlGroup)
      .plugTo( this, "Widigit")
      ;

    Letter[0] = "A";
    Letter[1] = "B";
    Letter[2] = "C";
    Letter[3] = "D";
    Number[0] = "1";
    Number[1] = "2";
    Number[2] = "3";
    Number[3] = "4";
  }//end initial setup


  StringDict update(StringDict Status, FloatDict Attitude) {  
    fill(0); 
    rect(0, 0, pane_W, pane_H);

    //Camera View--------------------------
    strokeWeight(1);
    rectMode(CORNER); 
    textAlign(CENTER, CENTER);
    textSize(14);
    //Display background
    switch(Status.get("FwdCamState")) {
    case "Off" : //Camera is not connected
      fill(50);
      stroke(0);
      strokeWeight(1);
      rectMode(CORNER); 
      rect(pane_x, pane_y, pane_W, pane_H);
      break;
    case "On" : //Camera is connected
      PImage test = fwdCam;
      if (fwdCam.isAvailable()) {
        fwdCam.read(); 
        test.resize(pane_W, pane_H);
        image(test, pane_x, pane_y, pane_W, pane_H);
      } else {
        image(test, pane_x, pane_y, pane_W, pane_H);
      }
      break;
    }//end switch

    //add pane elements
    pushStyle();
    fill(0);
    stroke(100);
    strokeWeight(1);
    beginShape();
    vertex(0, 0);
    vertex(0, 30);
    vertex(205, 30);
    vertex(250, 0);
    endShape(CLOSE);

    beginShape();
    vertex(end_x, end_y);
    vertex(end_x, end_y-30);
    vertex(end_x-205, end_y-30);
    vertex(end_x-250, end_y);
    endShape(CLOSE);
    popStyle();


    //Display framerate
    pushStyle();
    fill(255); 
    textSize(10);
    text("FPS: "+round(frameRate), end_x-35, end_y-7);
    text("Cam: "+Status.get("FwdCamState"), end_x-35, end_y-22);
    textSize(16);
    text("Fwd Camera", end_x-135, end_y-17);
    popStyle();


    switch(WidgitNumber) {
    case 0:
      //blank case
      break;

    case 1:
      //cross hairs
      pushStyle();
      stroke(100);
      strokeWeight(1);
      textSize(14);
      fill(100);

      k = 0;
      l = 0;
      for (float i = 0; i<5; i=i+1) {
        k = i/4;
        for (float j=0; j<5; j=j+1) {
          l = j/4;
          line(pane_W*(k)-8, pane_H*(l), pane_W*(k)+8, pane_H*(l));
          line(pane_W*(k), pane_H*(l)-8, pane_W*(k), pane_H*(l)+8);
        }
      }
      for (float i=0; i<4; i=i+1) {
        text(Letter[int(i)], 8, (0.125*pane_H)+((i/4)*pane_H));
        text(Letter[int(i)], end_x-9, (0.125*pane_H)+((i/4)*pane_H));

        if (i>0) {
          text(Number[int(i)], (0.125*pane_W)+((i/4)*pane_W), 8);
        }

        if (i<3) {
          text(Number[int(i)], (0.125*pane_W)+((i/4)*pane_W), end_y-13);
        }
      }//end for
      popStyle();
      break;

    case 2:
      //ArtificalHorrizion
      pushStyle();
      stroke(100);
      strokeWeight(1);
      textSize(18);
      noFill();

      ellipse(center_x, center_y, 25, 25);
      line(center_x+50, center_y, center_x+200, center_y);
      line(center_x-50, center_y, center_x-200, center_y);
      popStyle();
      break;
    }//end switch case

    return Status;
  }//end update


  void CameraConnection() {
    VC_Client.publish("USS/TS/VC/FwdCamControl", "CamStart");
    fwdCam.start(); 
    Status.set("FwdCamState", "On");
  }//end cameraConnection

  void CameraExit() {
    VC_Client.publish("USS/TS/VC/FwdCamControl", "CamEnd");
    fwdCam.stop();
    Status.set("FwdCamState", "Off");
  }//end cameraConnection

  void Widigit() {
    WidgitNumber = WidgitNumber+1;
    if (WidgitNumber>2) {
      WidgitNumber=0;
    }
  }//end cameraConnection
}//end class
