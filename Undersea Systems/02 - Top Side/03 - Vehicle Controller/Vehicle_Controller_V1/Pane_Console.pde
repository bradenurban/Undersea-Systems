class PaneConsole {
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



  PaneConsole(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
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
    fill(175);
    rect(pane_x, pane_y, pane_x+pane_W, pane_y+pane_H);
    Textarea consoleArea;
    Println console;
    PaneView_GUI.enableShortcuts();
    
    consoleArea = PaneView_GUI.addTextarea("txt")
      .setPosition(pane_x+1, pane_y+41)
      .setSize(400, 200)
      .setFont(createFont("", 12))
      .setLineHeight(14)
      .setColor(color(200))
      .setColorBackground(color(0))
      .setColorForeground(color(255));

  PaneView_GUI.addButton("Console")
      .setPosition(pane_x+1, pane_y+1)
      .setSize(400, 20);

    PaneView_GUI.addButtonBar("ConsoleMenu")
      .setPosition(pane_x+1, pane_y+22)
      .setSize(400, 20)
      .addItems(split("Pause Play Clear", " "));
      
     console = PaneView_GUI.addConsole(consoleArea);//  

      
      
  }//end initial setup
}//end class
