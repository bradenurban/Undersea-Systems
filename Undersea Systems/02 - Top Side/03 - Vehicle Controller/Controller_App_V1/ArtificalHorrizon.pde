class ArtificalHorrizon {
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
  float pitch;
  float roll;
  float pitch_offset;
  float roll_offset;



  ArtificalHorrizon() {
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
  }//end initial setup


  StringDict update(StringDict Status, FloatDict Attitude) {  
    pushStyle();
    //initial fill 
    fill(0);
    stroke(255);
    strokeWeight(1);
    rect(pane_x, pane_y, pane_W, pane_H);

    fill(#006183);
    stroke(0);

    rect(pane_x+1, pane_y+1, pane_W-2, pane_H-2);

    //max 20 degree pitch just finding percentage of max pitch to height, calculate offset from center here
    pitch = Attitude.get("Pitch");
    pitch_offset = int((pitch/20)*(center_y-zero_y));

    //roll is calculated here
    roll = radians(Attitude.get("Roll"));
    roll_offset = tan(roll)*(center_x-zero_x);

    //ground with offset
    fill(#9B6000);
    quad(pane_x+1, end_y-1, 
      end_x-2, end_y-2, 
      end_x-2, center_y+pitch_offset+roll_offset, 
      pane_x+1, center_y+pitch_offset-roll_offset);

    //onscreen center
    noFill();
    stroke(color(0,255,0));
    ellipse(center_x, center_y, 15, 15);
    line(pane_x+30, center_y, center_x-20, center_y);
    line(end_x-30, center_y, center_x+20, center_y);

    //roll indicator
    noFill();
    arc(center_x,center_y,165,165,radians(240),radians(300));
    fill(color(0,255,0));
    triangle(center_x,center_y-83,
             center_x-5,center_y-83-8,
             center_x+5,center_y-83-8);
    
    pushMatrix();
    //translate();
    
    popMatrix();
    
    
    popStyle();
    return Status;
  }//end update
}//end class
