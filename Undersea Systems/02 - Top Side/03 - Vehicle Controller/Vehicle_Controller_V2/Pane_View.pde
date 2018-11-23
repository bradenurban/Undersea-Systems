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

  Compass Compass1 = new Compass();
  ArtificalHorrizon ArtificalHorrizon1 = new ArtificalHorrizon();

  Pane_View() {
  }
  //Class Functions--------------------------------------- 
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
    Compass1.initialSetup(pane_x+pane_W - 175, center_y - 100, 150, 150);
    ArtificalHorrizon1.initialSetup(zero_x,zero_y,pane_W,pane_H);
    
  } // end initialUpdate


  //----------
  StringDict update(StringDict Status) {  

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

    Heading = int(Status.get("CurrentHeading"));
    Compass1.update(Status, Heading);
    ArtificalHorrizon1.update(Status, Attitude);
    
    
    return Status;
  } //end update

//---------------------------------------------------------
  class Compass {
    int CM_pane_x;
    int CM_pane_y;
    int CM_pane_W;
    int CM_pane_H;
    int CM_center_x;
    int CM_center_y;
    int CM_zero_y;
    int CM_zero_x;
    int CM_end_y;
    int CM_end_x;
    int CM_D;
    float CM_r;
    float CM_theta;

    color textColor = #0AE300;

    Compass() {
    }


    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      CM_pane_x = temp_pane_x;
      CM_pane_y = temp_pane_y;
      CM_pane_W = temp_pane_W;
      CM_pane_H = temp_pane_H;
      CM_center_x = CM_pane_x+(CM_pane_W/2);
      CM_center_y = CM_pane_y+(CM_pane_H/2);
      CM_zero_y = CM_pane_y+1;
      CM_zero_x = CM_pane_x+1;
      CM_end_y = temp_pane_y - 1;
      CM_end_x = temp_pane_x - 1;
      CM_D = CM_pane_W;
      CM_r = CM_D/2;
      CM_theta = 0;
    }// end initial setup

    void update(StringDict Status, float Heading) {
      fill(25);
      stroke(0);
      strokeWeight(1);
      ellipseMode(CENTER);
      compBackground(Heading);
      Ticks(45, 15, Heading, CM_D);
    }// end update

    void compBackground(float Heading) {

      //Draw Background
      stroke(0);
      strokeWeight(1);
      ellipseMode(CENTER);
      rectMode(CORNER);
      fill(50);

      pushMatrix();
      translate(CM_center_x, CM_center_y);
      rotate(PI);
      arc(0, 0, CM_D+25, CM_D+25, 0, PI, OPEN);
      noStroke();
      rect(-(CM_D+25)/2, 0, CM_D+25, -100);
      pushMatrix();
      rotate(PI);
      stroke(0);
      arc(0, 100, CM_D+25, CM_D+25, 0, PI, OPEN);
      popMatrix();
      line(-(CM_D+25)/2, 0, -(CM_D+25)/2, -100);
      line(1+(CM_D+25)/2, 0, 1+(CM_D+25)/2, -100);
      popMatrix();

      fill(#252C4D);
      ellipse(CM_center_x, CM_center_y, CM_D, CM_D); 

      //Current Heading
      noFill();
      rectMode(CENTER);
      stroke(#00FF00);
      rect(CM_center_x, CM_center_y+100, 60, 25);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(16);
      textAlign(CENTER, CENTER);
      fill(#00FF00);
      text(str(Heading), CM_center_x, CM_center_y+95);
      textSize(12);
      text("MODE: "+Status.get("HeadingMode"), CM_center_x, CM_center_y+125);
      fill(#FF0000);
      text("TARGET: "+Status.get("Target"), CM_center_x, CM_center_y+140);

      //Target
      noFill();
      rectMode(CENTER);
      stroke(#FF0000);
      rect(CM_center_x, CM_center_y+165, 40, 20);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(14);
      textAlign(CENTER, CENTER);
      fill(#FF0000);
      if(Status.get("Target")=="NONE"){
        text("000", CM_center_x, CM_center_y+160);}
        else{text(Status.get("TargetHeading"), CM_center_x, CM_center_y+160);}



      rectMode(CORNER);

      //North marker
      fill(#00FF00); //red fill
      stroke(0);
      int triSize = 7;
      triangle(CM_center_x, CM_center_y-CM_r+5, 
        CM_center_x+triSize, CM_center_y-CM_r-triSize-2, 
        CM_center_x-triSize, CM_center_y-CM_r-triSize-2);
    }//end compBackground

    void Ticks(int Majorspacing, int Minorspacing, float Heading, int CM_D) {
      int inner_MajorTick = (CM_D - 10)/2;
      int outer_MajorTIck = (CM_D)/2;

      int inner_MinorTick = (CM_D - 5)/2;
      int outer_MinorTick = (CM_D)/2; 

      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(10);
      textAlign(CENTER, CENTER);

      pushMatrix();
      translate(CM_center_x, CM_center_y);
      rotate(-HALF_PI-radians(Heading));

      for (int i =0; i<360; i = i+1) {
        if (i % Majorspacing ==0) {
          fill(graphicColor);
          stroke(graphicColor);
          strokeWeight(2);
          int x1 = int(inner_MajorTick *  cos(radians(i)));
          int y1 = int(inner_MajorTick *  sin(radians(i)));
          int x2 = int(outer_MajorTIck *  cos(radians(i)));
          int y2 = int(outer_MajorTIck *  sin(radians(i)));
          line(x1, y1, x2, y2);
          pushMatrix();
          translate( int((inner_MajorTick-15)*cos(radians(i))), 
            int((inner_MajorTick-15)*sin(radians(i))));
          rotate(radians(i)+HALF_PI);
          text(str(i), 0, 0);
          popMatrix();
        }//end if

        if ( i == 0) {
          pushMatrix();
          translate( int((inner_MajorTick-35)*cos(radians(i))), 
            int((inner_MajorTick-35)*sin(radians(i))));
          rotate(-PI/2);
          textSize(16);
          fill(#00FF00);
          text("N", 0, 0);
          textSize(10);
          popMatrix();
        }
        if ( i == 180) {
          pushMatrix();
          translate( int((inner_MajorTick-35)*cos(radians(i))), 
            int((inner_MajorTick-35)*sin(radians(i))));
          rotate(3*-PI/2);
          textSize(12);
          fill(graphicColor);
          text("S", 0, 0);
          textSize(10);
          popMatrix();
        }
        if ( i == 90) {
          pushMatrix();
          translate( int((inner_MajorTick-35)*cos(radians(i))), 
            int((inner_MajorTick-35)*sin(radians(i))));
          rotate(2*-PI/2);
          textSize(12);
          fill(graphicColor);
          text("E", 0, 0);
          textSize(10);
          popMatrix();
        }
        if ( i == 270) {
          pushMatrix();
          translate( int((inner_MajorTick-35)*cos(radians(i))), 
            int((inner_MajorTick-35)*sin(radians(i))));
          rotate(4*-PI/2);
          textSize(12);
          fill(graphicColor);
          text("W", 0, 0);
          textSize(10);
          popMatrix();
        }

        if (i % Minorspacing ==0) {
          stroke(graphicColor);
          strokeWeight(1);
          int x1 = int(inner_MinorTick *  cos(radians(i)));
          int y1 = int(inner_MinorTick *  sin(radians(i)));
          int x2 = int(outer_MinorTick *  cos(radians(i)));
          int y2 = int(outer_MinorTick *  sin(radians(i)));
          line(x1, y1, x2, y2);
        }//end if
      }//end for

      stroke(#00FF00);
      strokeWeight(1.5);
      line(-20, 0, 20, 0);

      stroke(graphicColor);
      strokeWeight(1);
      line(0, -20, 0, 20);

      popMatrix();
      fill(100);
      stroke(0);
    }//end major ticks
  }
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

    void update(StringDict Status, float Heading) {
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
