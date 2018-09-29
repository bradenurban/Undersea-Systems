class PaneMission {
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

  PaneMission(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
    pane_x= temp_pane_x;
    pane_y= temp_pane_y;
    pane_W= temp_pane_W;
    pane_H= temp_pane_H;
    center_x = pane_x+(pane_W/2);
    center_y = pane_y+(pane_H/2);
    zero_y = pane_y+1;
    zero_x = pane_x+1;
    
    
    
  }

void initialSetup() {
rect(pane_x,pane_y,pane_x+pane_W,pane_y+pane_H);
    textAlign(CENTER, CENTER);
    PFont font = createFont("Yu Gothic UI Bold",12);
    
    
    PaneView_GUI.addButton("Start")
      .setValue(0)
      .setPosition(1,1)
      .setSize(110, 75)
      .setFont(font)
      .plugTo( this, "StartMission")
      .updateSize();
      
     PaneView_GUI.addButton("End")
      .setValue(0)
      .setPosition(1,1)
      .setSize(110, 75)
      .setFont(font)
      .plugTo( this, "StartMission")
      .updateSize();
 
  PaneView_GUI.addTextfield("Name")
     .setPosition(115,1)
     .setSize(100,25)
     .setAutoClear(false)
     ;




}//end initial setup


void StartMission() {
println("Start Mission");
PaneView_GUI.getController("Name").lock();
}//end start mission

void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}





}//End class
