class PaneStatus {
  int pane_x;
  int pane_y;
  int pane_W;
  int pane_H;
  int center_x = pane_x+(pane_W/2);
  int center_y = pane_y+(pane_H/2);
  int zero_y = pane_y+1;
  int zero_x = pane_x+1;
  int heading = 0;
  int heading_target = 0;
  int flag = 0;
  color graphicColor = #E200E3;
  color graphicColor2 = color(255, 0, 255, 75);
  color color_sky = #5E817F;
  color color_ground = #FFCA08;
  color textColor = #0AE300;
  color lockedColor = #EAEAEA;
  color unlockColor = color(0, 0, 0);
  int flag_MissionStarted = 0;
  int mode = 0;



  PaneStatus(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y+1;
    zero_x = pane_x+1;
    lockedColor = #EAEAEA;
    flag_MissionStarted = 0;
    textColor = #0AE300;
  }

  void initialSetup() {
    fill(50);
    rect(pane_x, pane_y, pane_x+pane_W, pane_y+pane_H);

    //Label
    fill(0, 45, 90);
    stroke(0);
    strokeWeight(0.5);
    rect(pane_x, pane_y, 200, 20);
    textFont(createFont("Yu Gothic UI Bold", 12));
    fill(255);
    textSize(18);
    textAlign(CENTER, CENTER);
    text("FWD CAM", pane_x+100, pane_y+6);

    fill(50);
    rect(pane_x, pane_y+20, 200, pane_H-20);
    doughnut_gauge(pane_x+55, 85, 5, 25, 0, 20, "V", "VOLTS");
    linear_gauge(pane_x+115, 85, 2, 25, 0, 20, "DOP", "SERIAL");
  }//end initial setup



  //-----------------------
  void doughnut_gauge(int x_loc, int y_loc, float value, float value_max, float value_min, float value_red, String Units, String Label) {

    float temp_arc_degrees = map(value_red, value_min, value_max, 135, 315);
    int r = 37;
    float theta = map(value, value_min, value_max, 135, 315);

    fill(0, 255, 0);
    arc(x_loc, y_loc, 75, 75, radians(135), radians(315), CENTER);
    fill(255, 0, 0);
    arc(x_loc, y_loc, 75, 75, radians(temp_arc_degrees), radians(315), CENTER);
    fill(50);
    arc(x_loc, y_loc, 50, 50, radians(135), radians(315), CENTER);
    stroke(50);
    strokeWeight(1.5);
    ellipse(x_loc, y_loc, 48, 48);

    stroke(255);
    strokeWeight(2.5);
    line(x_loc, y_loc, x_loc+(r*cos(radians(theta))), y_loc+ (r * sin(radians(theta))));

    textFont(createFont("Yu Gothic UI Bold", 12));
    fill(textColor);

    //Units text
    textSize(14);
    textAlign(LEFT, CENTER);
    text(Units, x_loc-15, y_loc+25);

    //Label
    textSize(12);
    textAlign(CENTER, CENTER);
    text(Label, x_loc, y_loc-50);

    //Value
    textSize(36);
    textAlign(LEFT, CENTER);
    text(round(value), x_loc+10, y_loc-5);
  }//end gauge


  void linear_gauge(int x_loc, int y_loc, String state ,float value, float value_max, float value_min, float value_red, String Units, String Label) {

    int w = 15;
    int h = 50;
    float h_red = map(value_max-value_red, value_min, value_max, 0, h);
    float y_value = map(value_max-value, value_min, value_max, 0, h);

    stroke(0);
    strokeWeight(1);
    fill(0, 255, 0);
    rect(x_loc-(w/2), y_loc-(h/2), w, h);
    fill(255, 0, 0);
    rect(x_loc-(w/2), y_loc-(h/2), w, h_red);
  
    if(state == "Valid"){
      stroke(255);
      strokeWeight(3);
      line(x_loc-(w/2)-2, y_value+y_loc-(h/2), x_loc+(w/2)+2, y_value+y_loc-(h/2));
    }
    
    textFont(createFont("Yu Gothic UI Bold", 12));
    fill(textColor);

    //Units text
    textSize(14);
    textAlign(LEFT, CENTER);
    text(Units, x_loc, y_loc+h+5);
    
    
    
    
    
  }//end linear guage
}//end class
