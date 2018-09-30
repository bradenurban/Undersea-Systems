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
  color lockedColor = #EAEAEA;
  color unlockColor = color(0, 0, 0);
  int flag_MissionStarted = 0;
  int mode = 0;

  String date;
  String time;
  int elapsedTime = 0;
  int missionStart = 0;
  
  String missionEnd;
  String elapsedTime_Formatted;
  String missionStarted_Formatted;

  PaneMission(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
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

    elapsedTime = 0;
   missionEnd= nf(0, 2)+":"+nf(0, 2)+":"+nf(0, 2);
   elapsedTime_Formatted = nf(0, 2)+":"+nf(0, 2)+":"+nf(0, 2);
   missionStarted_Formatted = nf(0, 2)+":"+nf(0, 2)+":"+nf(0, 2);
  }

  void initialSetup() {
    fill(65);
    rect(pane_x, pane_y, pane_x+pane_W, pane_y+pane_H);
    //textAlign(CENTER, CENTER);


    PaneView_GUI.addButtonBar("Menu")
      .setPosition(0, 0)
      .setSize(pane_W, 20)
      .addItems(split("Load Edit Type Settings Log", " "));

    PaneView_GUI.addButton("Start")
      .setValue(0)
      .setPosition(2, 22)
      .setSize(110, 70)
      .setColorBackground(color(80, 200, 50))
      .plugTo( this, "StartMission");

    PaneView_GUI.addButton("End")
      .setValue(0)
      .setPosition(2, 95)
      .setSize(110, 30)
      .setColorBackground(color(200, 50, 50))
      .plugTo( this, "EndMission");

    PaneView_GUI.addTextfield("Name")
      .setPosition(116, 22)
      .setSize(200, 24)
      .setAutoClear(false);
    PaneView_GUI.getController("Name").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER).setPaddingX(-25);

    PaneView_GUI.addButton("Log")
      .setValue(0)
      .setPosition(116, 49)
      .setSize(200, 24)
      .plugTo( this, "LogLocation");
      
     PaneView_GUI.addButton("Targets")
      .setValue(0)
      .setPosition(116, 76)
      .setSize(200, 24)
      .plugTo( this, "TargetsLocation");
      
     PaneView_GUI.addButton("Waypoints")
      .setValue(0)
      .setPosition(116, 102)
      .setSize(200, 24)
      .plugTo( this, "WaypointsLocation");
  }//end initial setup

  void update() {
    clock();
  }//End Update



  //---------------------
  void StartMission() {
    //Confirmation to Start Mission
    if (flag_MissionStarted == 0) {
      int n = showConfirmDialog(frame, "Start Mission?", "Confirmation Dialog", YES_NO_OPTION);
      if (n == 0) {
        println("Start Mission");
        flag_MissionStarted = 1;

        missionStart = millis();
        missionStarted_Formatted = nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);
        PaneView_GUI.getController("Name").lock();
        PaneView_GUI.getController("Name").setColorBackground(color(180, 180, 180));

        PaneView_GUI.getController("Log").lock();
        PaneView_GUI.getController("Log").setColorBackground(color(180, 180, 180));
      }
    } else {
      showMessageDialog(frame, "Mission Already Started", "Warning", WARNING_MESSAGE);
    }
  }//end start mission

  //---------------------
  void EndMission() {
    if (flag_MissionStarted == 1) {
      int m = showConfirmDialog(frame, "End Mission?", "Confirmation Dialog", YES_NO_OPTION);
      if (m == 0) {
        println("End Mission");
        flag_MissionStarted = 0;
        PaneView_GUI.getController("Name").unlock();
        PaneView_GUI.getController("Name").setColorBackground(color(0, 45, 90)) ;

        PaneView_GUI.getController("Start").unlock();
        PaneView_GUI.getController("Start").setColorBackground(color(80, 200, 50));

        PaneView_GUI.getController("Log").unlock();
        PaneView_GUI.getController("Log").setColorBackground(color(0, 45, 90));
        missionEnd = nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);
      }
    } else {
      showMessageDialog(frame, "Mission Not Started", "Warning", WARNING_MESSAGE);
    }
  }//end start mission

 //-------------------
  void LogLocation() {
    println("Set Log Location");
    selectFolder("Select a folder to process:", "log_folderSelected");
  }//endLog Location

 //-------------------
  void TargetsLocation() {
    println("Set Log Location");
    selectFolder("Select a folder to process:", "targets_folderSelected");
  }//endLog Location

 //-------------------
  void WaypointsLocation() {
    println("Set Log Location");
    selectFolder("Select a folder to process:", "waypoints_folderSelected");
  }//endLog Location

  //---------------------
  void input(String theText) {
    // automatically receives results from controller input
    println("a textfield event for controller 'input' : "+theText);
  }

  //---------------------
  void bar(int n) {
    // automatically receives results from controller input
    println("bar clicked, item-value:", n);
  }//end bar
  
  
  
  //---------------------
  void clock() {
    //create clock
    fill(50);
    stroke(0);
    strokeWeight(1);
    rect(350, 20, pane_W-350, pane_H-21+1);
    textAlign(RIGHT, CENTER);
    textFont(createFont("Yu Gothic UI Bold", 12));
    textSize(14);
    fill(textColor);
    date = year()+"-"+nf(month(), 2)+"-"+nf(day(), 2);
    time = nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);

    if (flag_MissionStarted == 1) {
      elapsedTime = millis()-missionStart;
      int total_seconds = elapsedTime/1000;
      int seconds = total_seconds;
      println("total Seconds: " +total_seconds);
      
      int hours = round(total_seconds/3600);
      int temp_hours = total_seconds%3600;

      
      int minutes = round(temp_hours/60);
      int temp_min = temp_hours%60;
      println("Mission Min: " +temp_min);
      
      if(total_seconds>=60){seconds = total_seconds-(minutes*60);}
      else{seconds = total_seconds;}

       elapsedTime_Formatted = nf(hours, 2)+":"+nf(minutes, 2)+":"+nf(seconds, 2);}


    text("DATE: "+date, 525+5, 25);
    text("CURRENT TIME: "+time, 530+5, 45);
    text("MISSION START: " + missionStarted_Formatted,530+5, 65);
    text("ELAPSED TIME: "+elapsedTime_Formatted, 530+5, 85);
    text("MISSION END:  "+missionEnd, 530+5, 105);

  }//end clock
}//End class
