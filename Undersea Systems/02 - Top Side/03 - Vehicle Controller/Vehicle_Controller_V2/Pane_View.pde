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

  int flag;

  color textColor = #0AE300;

  Compass Compass1 = new Compass();

  Pane_View() {
    flag = 0;
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
    end_y = temp_pane_y - 1;
    end_x = temp_pane_x - 1;


    //Inital Fill
    fill(100);
    rect(pane_x, pane_y, pane_W, pane_H);
    print("initial update");

    //widigt setup
    Compass1.initialSetup(pane_x+pane_W - 175, center_y - 100, 150, 150);
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
      rect(pane_x, pane_y, pane_W, pane_H);
      break;
    case "On" : //Camera is connected
      PImage test = fwdCam;
      if (fwdCam.isAvailable()) {
        fwdCam.read(); 
        test.resize(pane_W-1, pane_H-1);
        image(test, pane_x+1, pane_y+1, pane_W-1, pane_H-1);
      } else {
        image(test, pane_x+1, pane_y+1, pane_W-1, pane_H-1);
      }
      break;
    }  


    //widigits----------------------------------------------------------
    //Display framerate
    fill(200); 
    text("FPS: "+round(frameRate), pane_x+pane_W-25, pane_y+pane_H-10);


    Compass1.update(Status, 15);

    return Status;
  } //end update

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
      fill(200);
      stroke(0);
      strokeWeight(1);
      ellipseMode(CENTER);
      ellipse(CM_center_x, CM_center_y, CM_D+25, CM_D+25); 
      fill(10);
      ellipse(CM_center_x, CM_center_y, CM_D, CM_D); 

      //North marker
      fill(#FF0000); //red fill
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

      stroke(200);
      strokeWeight(2);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(10);
      textAlign(CENTER, CENTER);
      fill(200);

      pushMatrix();
      translate(CM_center_x, CM_center_y);
      rotate(-HALF_PI-radians(Heading));
      for (int i =0; i<360; i = i+1) {
        if (i % Majorspacing ==0) {
          fill(200);
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
          fill(#FF0000);
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
          fill(200);
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
          fill(200);
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
          fill(200);
          text("W", 0, 0);
          textSize(10);
          popMatrix();
        }
      
      if (i % Minorspacing ==0) {
        stroke(150);
        strokeWeight(1);
        int x1 = int(inner_MinorTick *  cos(radians(i)));
        int y1 = int(inner_MinorTick *  sin(radians(i)));
        int x2 = int(outer_MinorTick *  cos(radians(i)));
        int y2 = int(outer_MinorTick *  sin(radians(i)));
        line(x1, y1, x2, y2);
      }//end if
    }//end for


    popMatrix();
    fill(100);
  }//end major ticks
}



//----------
}//end class
