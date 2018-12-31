class Widgits {
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


  Widgits() {
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
  } // end initialUpdate


  void Lights(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
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
    fill(255);
    text("Lights", center_x, center_y);
  }

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


  void linear_gauge(int x_loc, int y_loc, String state, float value, float value_max, float value_min, float value_red, String Units, String Label) {

    int w = 10;
    int h = 52;
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
    text(Units, x_loc, y_loc+ h - 20);
    text(Label, x_loc, y_loc - 40);

    //return Stroke Weight back to black and 1
    stroke(0);
    strokeWeight(1);
  }//end linear guage

  void circle_gauge(int x_loc, int y_loc, String state, float value, float value_max, float value_min, float value_red, String Units, String Label) {

    int D = 150;

    pushStyle();
    pushMatrix();
    translate(x_loc, y_loc);
    stroke(color(#FF0000));
    strokeWeight(5);
    strokeCap(SQUARE);
    noFill();
    arc(0, 0, D, D, HALF_PI, HALF_PI+QUARTER_PI);
    stroke(color(#00FF00));
    noFill();
    arc(0, 0, D, D, HALF_PI+QUARTER_PI, PI+HALF_PI);



    popMatrix();
    popStyle();

    textFont(createFont("Yu Gothic UI Bold", 12));
    fill(textColor);


    //Units text
    textSize(12);
    textAlign(CENTER, CENTER);
  }//end linear guage


  void ForceGauge(int x_loc, int y_loc, StringDict Status, FloatDict Attitude) {
    int diam = 150;
    int radius = diam/2;

    //max acceleration is 2g (19.62 m/s)
    float x_acc = Attitude.get("Surge");
    float y_acc = Attitude.get("Sway");
    float z_acc = Attitude.get("Heave");

    //max rotation rate is 125deg/s (2.18 rad/s)
    float p_acc = Attitude.get("pitchRate");
    float r_acc = Attitude.get("rollRate");
    float yw_acc = Attitude.get("yawRate");

    int m_x_acc = int(0.5*radius*(x_acc/9.81));
    int m_y_acc = int(0.5*radius*(y_acc/9.81));
    int m_z_acc = int(0.5*radius*(z_acc/9.81));
    int m_p_acc = int(0.5*radius*(p_acc/125));
    int m_r_acc = int(0.5*radius*(r_acc/125));
    int m_yw_acc = int(0.5*radius*(yw_acc/125));

    // ship, down view
    pushMatrix();
    pushStyle();
    translate(x_loc-50, y_loc);

    fill(25);
    stroke(100);
    ellipse(0, 0, diam, diam);

    rect(81, -75, 10, 150);
    rect(-75, -91, 150, 10);

    fill(0);
    stroke(#00FF00);
    strokeWeight(1);

    beginShape();
    vertex(0, 0-(35));
    vertex(0-15, 0-(10));
    vertex(0-15, 0+(35));
    vertex(0+15, 0+(35));
    vertex(0+15, 0-(10));
    vertex(0, 0-(35));
    endShape(CLOSE);

    stroke(100);

    noFill();
    ellipse(0, 0, 15, 15);
    ellipse(0, 0, 30, 30);
    ellipse(0, 0, 60, 60);
    ellipse(0, 0, 90, 90);
    ellipse(0, 0, 120, 120);

    fill(0, 255, 0);
    stroke(0, 255, 0);
    line(0, 0, m_x_acc, m_y_acc);

    stroke(0);
    ellipse(m_x_acc, m_y_acc, 10, 10);

    strokeWeight(10);
    strokeCap(SQUARE);
    stroke(0, 255, 0);

    line(86, 0, 86, m_p_acc);
    line(0, -86, m_y_acc, -86);

    popStyle();
    popMatrix();

    // ship
    //pushMatrix();
    //pushStyle();
    //translate(x_loc-50, y_loc);

    //fill(25);
    //stroke(100);
    //ellipse(0,0,diam,diam);

    //rect(81,-75,10,150);
    //rect(-75,-91,150,10);

    //fill(0);
    //stroke(#00FF00);
    //strokeWeight(1);

    //beginShape();
    //vertex(0, 0-(35));
    //vertex(0-15, 0-(10));
    //vertex(0-15, 0+(35));
    //vertex(0+15, 0+(35));
    //vertex(0+15, 0-(10));
    //vertex(0, 0-(35));
    //endShape(CLOSE);

    //stroke(100);

    // popStyle();
    //popMatrix();
  }//end Force Gauge



  void Compass(int x_loc, int y_loc, int Diam, int Majorspacing, int Minorspacing, StringDict Status, FloatDict Attitude) {

    fill(25);
    stroke(#00FF00);
    strokeWeight(1);
    ellipseMode(CENTER);
    ellipse(x_loc, y_loc, Diam, Diam);

    fill(0);
    stroke(100);
    ellipse(x_loc, y_loc, Diam-120, Diam-120);

    stroke(#00FF00);

    int inner_MajorTick = (Diam - 20)/2;
    int outer_MajorTIck = (Diam)/2;

    int inner_MinorTick = (Diam - 10)/2;
    int outer_MinorTick = (Diam)/2; 
    int headingDiff = 0;

    textFont(createFont("Yu Gothic UI Bold", 12));
    textSize(10);
    textAlign(CENTER, CENTER);

    pushMatrix();
    translate(x_loc, y_loc);
    rotate(PI + HALF_PI);

    for (int i =0; i<360; i = i+1) {
      if (i % Majorspacing ==0) {
        fill(255);
        stroke(#00FF00);
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
        textSize(16);
        fill(#E200E3);
        text("S", 0, 0);
        textSize(10);
        popMatrix();
      }
      if ( i == 90) {
        pushMatrix();
        translate( int((inner_MajorTick-35)*cos(radians(i))), 
          int((inner_MajorTick-35)*sin(radians(i))));
        rotate(2*-PI/2);
        textSize(16);
        fill(#E200E3);
        text("E", 0, 0);
        textSize(10);
        popMatrix();
      }
      if ( i == 270) {
        pushMatrix();
        translate( int((inner_MajorTick-35)*cos(radians(i))), 
          int((inner_MajorTick-35)*sin(radians(i))));
        rotate(4*-PI/2);
        textSize(16);
        fill(#E200E3);
        text("W", 0, 0);
        textSize(10);
        popMatrix();
      }

      if (i % Minorspacing ==0) {
        stroke(#00FF00);
        strokeWeight(1);
        int x1 = int(inner_MinorTick *  cos(radians(i)));
        int y1 = int(inner_MinorTick *  sin(radians(i)));
        int x2 = int(outer_MinorTick *  cos(radians(i)));
        int y2 = int(outer_MinorTick *  sin(radians(i)));
        line(x1, y1, x2, y2);
      }//end if
    }//end for
    popMatrix();

    // ship showing heading
    pushMatrix();
    pushStyle();
    translate(x_loc, y_loc);
    rotate(radians(Attitude.get("Heading")));

    fill(0);
    stroke(#00FF00);
    strokeWeight(1);

    beginShape();
    vertex(0, 0-(52));
    vertex(0-20, 0-(20));
    vertex(0-20, 0+(45));
    vertex(0+20, 0+(45));
    vertex(0+20, 0-(20));
    vertex(0, 0-(52));
    endShape(CLOSE);

    stroke(#00FF00);
    line(0, 0-(52), 0, 0-Diam/2);

    popStyle();
    popMatrix();

    // Heading Target

    if (Status.get("Target").equals("None") == true) {
    } else {
      pushMatrix();
      pushStyle();
      translate(x_loc, y_loc);
      rotate(radians(float(Status.get("TargetHeading"))-2));

      stroke(#F58700);
      strokeWeight(2);
      line(0, -85, 0, -5-Diam/2);

      popStyle();
      popMatrix();

      pushMatrix();
      pushStyle();
      translate(x_loc, y_loc);
      rotate(radians(float(Status.get("TargetHeading"))+2));

      stroke(#F58700);
      strokeWeight(2);
      line(0, -85, 0, -5-Diam/2);

      popStyle();
      popMatrix();
    }

    if (Status.get("VO_Heading").equals("Null") == true) {
    } else {
      pushMatrix();
      pushStyle();
      translate(x_loc, y_loc);
      rotate(radians(float(Status.get("VO_Heading"))));

      stroke(#E200E3);
      strokeWeight(2);
      line(0, -95, 0, -5-Diam/2);

      popStyle();
      popMatrix();
    }

    //text current heading
    pushStyle();
    textAlign(LEFT, CENTER);
    textSize(12);
    fill(#00FF00);
    text("HEADING:", x_loc-140, y_loc+90);
    textSize(20);
    noFill();
    rect(x_loc-140, y_loc+100, 60, 25);
    text(str(round(Attitude.get("Heading"))), x_loc-140, y_loc+110);

    textSize(12);
    textAlign(RIGHT, CENTER);
    fill(#F58700);
    text("TARGET:", x_loc+140, y_loc+90);
    textSize(20);
    noFill();
    stroke(#F58700);
    rect(x_loc+80, y_loc+100, 60, 25);
    text(Status.get("TargetHeading"), x_loc+140, y_loc+110);

    textSize(12);
    textAlign(RIGHT, CENTER);
    fill(#E200E3);
    text("HOST:", x_loc+140, y_loc-90);
    textSize(20);
    text(Status.get("VO_Heading"), x_loc+140, y_loc-110);

    popStyle();

    //left or right gauge
    pushMatrix();
    pushStyle();
    translate(x_loc, y_loc);

    fill(255);
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);

    noFill();
    stroke(100);
    rect(-73, -142, 145, 19);

    fill(255);
    line(0, -125, 0, -140);

    headingDiff = int(Status.get("TargetHeading"))-int(Attitude.get("Heading"));

    if (headingDiff > 1) {
      rect(5, -140, 5, 15);
    }

    if (headingDiff < -1) {
      rect(-5, -140, -5, 15);
    }

    if (headingDiff > 3) {
      rect(15, -140, 5, 15);
    }

    if (headingDiff < -3) {
      rect(-15, -140, -5, 15);
    }

    if (headingDiff > 5) {
      rect(25, -140, 5, 15);
    }

    if (headingDiff < -5) {
      rect(-25, -140, -5, 15);
    }

    if (headingDiff > 7) {
      rect(35, -140, 5, 15);
    }

    if (headingDiff < -7) {
      rect(-35, -140, -5, 15);
    }

    if (headingDiff > 10) {
      rect(45, -140, 5, 15);
    }

    if (headingDiff < -10) {
      rect(-45, -140, -5, 15);
    }

    if (headingDiff > 13) {
      rect(55, -140, 5, 15);
    }

    if (headingDiff < -13) {
      rect(-55, -140, -5, 15);
    }
    if (headingDiff > 15) {
      rect(65, -140, 5, 15);
    }

    if (headingDiff < -15) {
      rect(-65, -140, -5, 15);
    }

    if (headingDiff > 20) {
      triangle(75, -140, 75, -125, 85, -132);
    }

    if (headingDiff < -20) {
      triangle(-75, -140, -75, -125, -85, -132);
    }

    popStyle();
    popMatrix();
  }// end compass
}//end class
