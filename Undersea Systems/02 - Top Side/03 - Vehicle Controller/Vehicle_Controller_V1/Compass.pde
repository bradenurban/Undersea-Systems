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
  color graphicColor2 = color(255,0,255,75);
  color textColor = #0AE300;
  int incrament;
  int headingline_major_x;
  int headingline_major_y;
  int headingline_minor_x;
  int headingline_minor_y;

  color c1 = color(255,255,255,100);
  color c2 = color(255,255,255,0);
  int Y_AXIS = 1;
  int X_AXIS = 2;
  
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
  
  
  void headingdisplay(int heading, int mode, int target){
    //Compass display, no heading target
    stroke(graphicColor2);
    strokeWeight(1.5);
    strokeJoin(MITER);
    strokeCap(SQUARE);
    ellipseMode(CENTER);
    noFill();

    //bar
    int offset_x = 85;
    int offset_y = 25;
    beginShape();
    vertex(pane_x+offset_x,            pane_y+offset_y   );
    vertex(pane_x+offset_x+15,         pane_y+offset_y+15);
    vertex(pane_x+pane_W-offset_x-15,  pane_y+offset_y+15);
    vertex(pane_x+pane_W-offset_x,     pane_y+offset_y);
    endShape();
    
    //Current Heading shape
    fill(color(0,0,0,85));
    beginShape();
    vertex(center_x-30,                pane_y+2            );
    vertex(center_x-20,                pane_y+offset_y+15   );
    vertex(center_x+20,                pane_y+offset_y+15   );
    vertex(center_x+30,                pane_y+2            );
    endShape();
    
    //current heading text
    textAlign(CENTER, CENTER);
    textFont(createFont("Yu Gothic UI Bold",12));
    textSize(24);
    fill(textColor);
    text(str(heading),      center_x,pane_y+15);
    
    textSize(20);
    text(str(heading+5), center_x+50,pane_y+5);
    text(str(heading-5), center_x-50,pane_y+5);
    
    textSize(12);
    text(str(heading+10), center_x+80,pane_y+5);
    text(str(heading-10), center_x-80,pane_y+5);
    
    fill(graphicColor);
    beginShape();
    vertex(pane_x+pane_W-offset_x-45,   pane_y+30   );
    vertex(pane_x+pane_W-offset_x-60,   pane_y+25   );
    vertex(pane_x+pane_W-offset_x-60,   pane_y+35   );
    endShape();
    
    beginShape();
    vertex(pane_x+offset_x+45,   pane_y+30   );
    vertex(pane_x+offset_x+60,   pane_y+25   );
    vertex(pane_x+offset_x+60,   pane_y+35   );
    endShape();
    
    fill(textColor);
    textSize(24);
    if(heading >= 0 && heading <90){text("E", pane_x+pane_W-offset_x-30,pane_y+25);  text("N", pane_x+offset_x+30,pane_y+25);}
    if(heading >= 90 && heading <180){text("S", pane_x+pane_W-offset_x-30,pane_y+25);text("E", pane_x+offset_x+30,pane_y+25);}
    if(heading >= 180 && heading <270){text("W", pane_x+pane_W-offset_x-30,pane_y+25);text("S", pane_x+offset_x+30,pane_y+25);}
    if(heading >= 270 && heading <360){text("N", pane_x+pane_W-offset_x-30,pane_y+25);text("W", pane_x+offset_x+30,pane_y+25);}
    
    //current heading mode
    textSize(12);
    textAlign(LEFT, CENTER);
    fill(255,255,255,100);
    if(mode==0){text("MODE: MANUAL",center_x+30,pane_y+offset_y+5);}
    if(mode==1){text("MODE: AUTO",center_x+30,pane_y+offset_y+5);}
    
    //current heading TARGET
    textSize(12);
    textAlign(RIGHT, CENTER);
    fill(255,255,255,100);
    if(target==0){text("TARGET: NONE",center_x-30,pane_y+offset_y+5);}
    if(target==1){text("TARGET: WP1",center_x-30,pane_y+offset_y+5);}



} // end compass, no heading target
  
  
  
  
  
  
}//end class
