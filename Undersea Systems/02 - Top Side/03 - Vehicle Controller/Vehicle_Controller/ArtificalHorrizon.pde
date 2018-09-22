class ArtificalHorrizon{
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
  color graphicColor2 = color(255,0,255,75);
  color textColor = #0AE300;
  
  
  
  ArtificalHorrizon(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H){
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
  void AHdisplay(int pitch, int roll, int pitch_target, int roll_target, int mode){
    int offset_x = 50;
    int offset_y = 85;
    
    
    stroke(graphicColor2);
    strokeWeight(1);
    strokeJoin(MITER);
    strokeCap(SQUARE);
    ellipseMode(CENTER);
    noFill();
    ellipse(center_x,center_y,50,50);
    ellipse(center_x,center_y,8,8);
    
    strokeWeight(1);
    line(center_x-50,center_y,center_x-400,center_y);
    line(center_x+50,center_y,center_x+400,center_y);
    

    
  }//end AHdisplay
  
}//end class
