class Compass {
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
  int Diam;
  float k;
  float l;
  String[] Letter = new String[4];
  String[] Number= new String[4];
  int Majorspacing;
  int Minorspacing;



  Compass() {
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
    Diam = int(0.75*(end_x - pane_x));
    Majorspacing = 45;
    Minorspacing = 5;

    
  }//end initial setup


  StringDict update(StringDict Status, FloatDict Attitude) {  

    fill(25);
    stroke(#00FF00);
    strokeWeight(1);
    ellipseMode(CENTER);
    ellipse(center_x, center_y, Diam, Diam);

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
    translate(center_x, center_y);
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
        translate( int((inner_MajorTick-5)*cos(radians(i))), 
          int((inner_MajorTick-5)*sin(radians(i))));
        rotate(radians(i)+HALF_PI);
        text(str(i), 0, 0);
        popMatrix();
      }//end if

      if ( i == 0) {
        pushMatrix();
        translate( int((inner_MajorTick-25)*cos(radians(i))), 
          int((inner_MajorTick-25)*sin(radians(i))));
        rotate(-PI/2);
        textSize(16);
        fill(#00FF00);
        text("N", 0, 0);
        textSize(10);
        popMatrix();
      }
      if ( i == 180) {
        pushMatrix();
        translate( int((inner_MajorTick-25)*cos(radians(i))), 
          int((inner_MajorTick-25)*sin(radians(i))));
        rotate(3*-PI/2);
        textSize(16);
        fill(#E200E3);
        text("S", 0, 0);
        textSize(10);
        popMatrix();
      }
      if ( i == 90) {
        pushMatrix();
        translate( int((inner_MajorTick-25)*cos(radians(i))), 
          int((inner_MajorTick-25)*sin(radians(i))));
        rotate(2*-PI/2);
        textSize(16);
        fill(#E200E3);
        text("E", 0, 0);
        textSize(10);
        popMatrix();
      }
      if ( i == 270) {
        pushMatrix();
        translate( int((inner_MajorTick-25)*cos(radians(i))), 
          int((inner_MajorTick-25)*sin(radians(i))));
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
    translate(center_x, center_y);
    rotate(radians(Attitude.get("Heading")));

    fill(0);
    stroke(#00FF00);
    strokeWeight(1);

    beginShape();
    vertex(0, 0-(35));
    vertex(0-12, 0-(10));
    vertex(0-12, 0+(30));
    vertex(0+12, 0+(30));
    vertex(0+12, 0-(10));
    endShape(CLOSE);

    stroke(#00FF00);
    strokeWeight(2);
    line(0, 0-(35), 0, 0-Diam/2);

    popStyle();
    popMatrix();

    // Heading Target
    if (Status.get("Target").equals("None") == true) {
    } else {
      pushMatrix();
      pushStyle();
      translate(center_x, center_y);
      rotate(radians(float(Status.get("TargetHeading"))-2));

      stroke(#F58700);
      strokeWeight(2);
      line(0, -10-Diam/2, 0, 10-Diam/2);

      popStyle();
      popMatrix();

      pushMatrix();
      pushStyle();
      translate(center_x, center_y);
      rotate(radians(float(Status.get("TargetHeading"))+2));

      stroke(#F58700);
      strokeWeight(2);
      line(0, -10-Diam/2, 0, 10-Diam/2);

      popStyle();
      popMatrix();
    }

    //text current heading
    pushStyle();
    textAlign(LEFT, CENTER);
    textSize(10);
    fill(#00FF00);
    text("HEADING:", center_x-95, center_y+75);
    textSize(18);
    noFill();
    rect(center_x-95, center_y+100, 60, 25);
    text(str(round(Attitude.get("Heading"))), center_x-95, center_y+86);

    textSize(10);
    textAlign(RIGHT, CENTER);
    fill(#F58700);
    text("TARGET:", center_x+95, center_y+75);
    textSize(18);
    noFill();
    stroke(#F58700);
    rect(center_x+95, center_y+100, 60, 25);
    text(Status.get("TargetHeading"), center_x+95, center_y+86);

    popStyle();

    //left or right gauge
    pushMatrix();
    pushStyle();
    translate(center_x, center_y);

    fill(255);
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);

    noFill();
    stroke(100);
    rect(-73, -95, 145, 15);

    fill(255);
    line(0, -95+15, 0, -95);

    headingDiff = int(Status.get("TargetHeading"))-int(Attitude.get("Heading"));

    if (headingDiff > 1) {
      rect(5, -94, 5, 13);
    }

    if (headingDiff < -1) {
      rect(-5, -94, -5, 13);
    }

    if (headingDiff > 3) {
      rect(15, -94, 5, 13);
    }

    if (headingDiff < -3) {
      rect(-15, -94, -5, 13);
    }

    if (headingDiff > 5) {
      rect(25, -94, 5, 13);
    }

    if (headingDiff < -5) {
      rect(-25, -94, -5, 13);
    }

    if (headingDiff > 7) {
      rect(35, -94, 5, 13);
    }

    if (headingDiff < -7) {
      rect(-35, -94, -5, 13);
    }

    if (headingDiff > 10) {
      rect(45, -94, 5, 13);
    }

    if (headingDiff < -10) {
      rect(-45, -94, -5, 13);
    }

    if (headingDiff > 13) {
      rect(55, -94, 5, 13);
    }

    if (headingDiff < -13) {
      rect(-55, -94, -5, 13);
    }
    if (headingDiff > 15) {
      rect(65, -94, 5, 13);
    }

    if (headingDiff < -15) {
      rect(-65, -94, -5, 13);
    }

    if (headingDiff > 20) {
      triangle(75, -94, 75, -81, 85, -87);
    }

    if (headingDiff < -20) {
      triangle(-75, -94, -75, -81, -85, -87);
    }

    popStyle();
    popMatrix();
    
    return Status;
  }// end compass





}//end class
