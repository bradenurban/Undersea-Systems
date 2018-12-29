class Pane_View {
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
  int Heading;
  int Attitude;

  color textColor = #0AE300;
  color graphicColor = #E200E3;
  color graphicColor2 = color(0, 255, 00, 75);

  ArtificalHorrizon ArtificalHorrizon1 = new ArtificalHorrizon();

  Pane_View() {
  }

  void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y+1;
    zero_x = pane_x+1;
    end_y = temp_pane_y ;
    end_x = temp_pane_x ;


    //Inital Fill
    fill(100);
    rect(pane_x, pane_y, pane_W, pane_H);

    //widigt setup
    //Compass1.initialSetup(pane_x+pane_W - 175, center_y - 100, 150, 150);
    ArtificalHorrizon1.initialSetup(zero_x,zero_y,pane_W,pane_H);
    
  } // end initialUpdate


  //----------
  StringDict update(StringDict Status, FloatDict Attitude) {  

    strokeWeight(1);
    rectMode(CORNER); 
    textAlign(CENTER, CENTER);
    textSize(14);
    //Display background
    switch(Status.get("FwdCamState")) {
    case "Off" : //Camera is not connected
      fill(100);
      stroke(0);
      strokeWeight(1);
      rectMode(CORNER); 
      rect(pane_x+1, pane_y+1, pane_W, pane_H);
      break;
    case "On" : //Camera is connected
      PImage test = fwdCam;
      if (fwdCam.isAvailable()) {
        fwdCam.read(); 
        test.resize(pane_W, pane_H);
        image(test, pane_x+1, pane_y+1, pane_W, pane_H);
      } else {
        image(test, pane_x+1, pane_y+1, pane_W, pane_H);
      }
      break;
    }  


//widigits----------------------------------------------------------
    //Display framerate
    fill(200); 
    text("FPS: "+round(frameRate), pane_x+pane_W-25, pane_y+pane_H-10);

    Heading = int(Attitude.get("Heading"));
    //Compass1.update(Status, Heading);
    ArtificalHorrizon1.update(Status, Attitude);
    
    
    return Status;
  } //end update

//---------------------------------------------------------

//---------------------------------------------------------
  class ArtificalHorrizon {
    int AH_pane_x;
    int AH_pane_y;
    int AH_pane_W;
    int AH_pane_H;
    int AH_center_x;
    int AH_center_y;
    int AH_zero_y;
    int AH_zero_x;
    int AH_end_y;
    int AH_end_x;
    int AH_D;
    float AH_r;
    float AH_theta;

    color textColor = #0AE300;

    ArtificalHorrizon() {
    }


    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      AH_pane_x = temp_pane_x;
      AH_pane_y = temp_pane_y;
      AH_pane_W = temp_pane_W;
      AH_pane_H = temp_pane_H;
      AH_center_x = AH_pane_x+(AH_pane_W/2);
      AH_center_y = AH_pane_y+(AH_pane_H/2);
      AH_zero_y = AH_pane_y+1;
      AH_zero_x = AH_pane_x+1;
      AH_end_y = temp_pane_y - 1;
      AH_end_x = temp_pane_x - 1;
      AH_D = AH_pane_W;
      AH_r = AH_D/2;
      AH_theta = 0;
    }// end initial setup

    void update(StringDict Status, FloatDict Attitude) {
      noFill();
      stroke(graphicColor,75);
      strokeWeight(1);
      ellipseMode(CENTER);
      ellipse(AH_center_x,AH_center_y,10,10);
      ellipse(AH_center_x,AH_center_y,75,75);
      line(AH_center_x+55, AH_center_y, AH_center_x+300,AH_center_y);
      line(AH_center_x-55, AH_center_y, AH_center_x-300,AH_center_y);
 
 
      stroke(0);
      strokeWeight(1);
    }// end update


  }//END ARTIFICAL HORRIZON CLASS












  //----------
}//end class
