class Depth{
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
  color textColor = #0AE300;
  color graphicColor2 = color(255,0,255,75);
  
  
  
  Depth(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H){
  pane_x= temp_pane_x;
  pane_y= temp_pane_y;
  pane_W= temp_pane_W;
  pane_H= temp_pane_H;
  center_x = pane_x+(pane_W/2);
  zero_y = pane_y+1;
  zero_x = pane_x+1;
  
  }
//Class Functions--------------------------------------- 
  void DepthDisplay(int depth, int depth_max, int depth_target){
    int offset_x = 25;
    int offset_y = 85;
    
    stroke(graphicColor2);
    strokeWeight(1.5);
    strokeJoin(MITER);
    strokeCap(SQUARE);
    line(pane_x+offset_x,    pane_y+offset_y,     pane_x+offset_x+15,  pane_y+offset_y+15);
    line(pane_x+offset_x+15, pane_y+offset_y+15,  pane_x+offset_x+15,  pane_y+offset_y+500);
    line(pane_x+offset_x+15, pane_y+offset_y+500, pane_x+offset_x,     pane_y+offset_y+500+15);
  
  
  
  
  }//end AHdisplay
  
}//end class
