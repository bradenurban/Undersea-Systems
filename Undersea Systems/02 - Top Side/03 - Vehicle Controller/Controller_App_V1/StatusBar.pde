class StatusBar {
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


  StatusBar() {
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
    fill(100);
    stroke(255);
    strokeWeight(1);
    rect(0, 0, pane_W, 20);

    //Date
    textSize(12);
    fill(255);
    textAlign(LEFT,CENTER);
    text("DATE: "+year()+"-"+month()+"-"+day(),2,8);
    line(100,0,100,20);
    
    //Time
    textSize(12);
    fill(255);
    text("TIME: "+hour()+":"+minute()+":"+second(),105,8);
    line(190,0,190,20);

    //Position 
    //----------------need to update--------------------
    textSize(12);
    fill(255);
    text("GPS: 0 0.0000N | 0 0.0000W",195,8);
    line(350,0,350,20);

    //Frame Rate
    textSize(12);
    fill(255);
    text("FPS: "+round(frameRate),355,8);
    line(350,0,350,20);





    popStyle();
    return Status;
  }//end update
}//end class
