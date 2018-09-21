class Compass{
  int pane_x;
  int pane_y;
  int pane_W;
  int pane_H;
  int center_x = pane_x+(pane_W/2);
  int zero_y = pane_y+1;
  int zero_x = pane_x+1;
  int heading = 0;
  int heading_target = 0;
  int flag = 0;
  color graphicColor = #E200E3;
  color textColor = #0AE300;
  
  Compass(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H){
  pane_x= temp_pane_x;
  pane_y= temp_pane_y;
  pane_W= temp_pane_W;
  pane_H= temp_pane_H;
  center_x = pane_x+(pane_W/2);
  zero_y = pane_y+1;
  zero_x = pane_x+1;
  
  }
//Class Functions--------------------------------------- 
  
  
  void headingdisplay(int heading){
    //Compass display, no heading target
    
    //
    stroke(graphicColor);
    strokeWeight(1.5);
    noFill();
    beginShape();
    vertex(center_x-5,  zero_y);
    vertex(center_x-5,  zero_y+25);
    vertex(center_x-25, zero_y+35);
    vertex(center_x-25, zero_y+65);
    
    vertex(center_x+25, zero_y+65);
    vertex(center_x+25, zero_y+35);
    vertex(center_x+5,  zero_y+25);
    vertex(center_x+5,  zero_y);
    endShape(CLOSE);
    
    textSize(18);
    fill(textColor);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    text(str(round(heading)),center_x,zero_y+45);
    
     
     
    } // end compass, no heading target
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}//end class
