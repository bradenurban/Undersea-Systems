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
    translate(x_loc,y_loc);
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
}//end class
