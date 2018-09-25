class ArtificalHorrizon {
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
  int mode = 0;
  int roll_offset = 0;
  int pitch_offset = 0;
  int pitch_factor = pane_W/2; //factor for showing pitch, just picking this for now



  ArtificalHorrizon(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y+1;
    zero_x = pane_x+1;
  }
  //Class Functions--------------------------------------- 
  void AHdisplay(float pitch, float roll, float pitch_target, float roll_target, int temp_mode) {
    mode = temp_mode;
    int offset_x = 50;
    int offset_y = 85;
    pitch_factor = pane_W/4; 

    
    
    //Horrizon Location-------
    roll_offset = int(   (pane_W/2)*tan(radians(roll))   );
    pitch_offset = int(   (pitch_factor)*tan(radians(pitch))   );

    switch(mode) {
    case 0: // artificial horrizon
      println("AH on");
      //stroke(#000000);
      //strokeWeight(1);
      //strokeJoin(MITER);
      //strokeCap(SQUARE);
      
      //sky fill
      fill(color_sky);
      quad(  pane_x+1,        pane_y+1, 
             pane_x+pane_W-1, pane_y+1, 
             pane_x+pane_W-1, 1+center_y+roll_offset+pitch_offset,
             pane_x+1,        1+center_y-1-roll_offset+pitch_offset);



      break;
    case 1: //camera feed

      break;
    }//end switch








    //other graphics

    stroke(graphicColor2);
    strokeWeight(1);
    strokeJoin(MITER);
    strokeCap(SQUARE);
    ellipseMode(CENTER);
    noFill();
    ellipse(center_x, center_y, 50, 50);
    ellipse(center_x, center_y, 8, 8);

    strokeWeight(1);
    line(center_x-50, center_y, center_x-400, center_y);
    line(center_x+50, center_y, center_x+400, center_y);
  }//end AHdisplay
}//end class
