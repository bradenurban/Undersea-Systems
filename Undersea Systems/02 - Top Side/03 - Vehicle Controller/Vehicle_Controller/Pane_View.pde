class PaneView {
  int pane_x;
  int pane_y;
  int pane_W;
  int pane_H;
  int temp_heading;
  //Camera variable 
  int flag = 0;
  boolean fwdCam_state = true;
  
  PaneView(){

  
  }
  
  
  
 //Class Functions--------------------------------------- 
  void initialSetup(int temp_pane_x,int temp_pane_y, int temp_pane_W,int temp_pane_H){
    pane_x = temp_pane_x;
    pane_y = temp_pane_y;
    pane_W = temp_pane_W;
    pane_H = temp_pane_H;
    
    //Inital Fill
    fill(100);
    rect(pane_x,pane_y,pane_W,pane_H);
    print("initial update");
    
    
    //Connection Button
    PaneView_GUI.addButton("CameraConnection")
     .setValue(0)
     .setPosition(pane_x+temp_pane_W,pane_y)
     .setSize(50,50)
     .setImages(loadImage("Disconnected_Base.png"),loadImage("Disconnected_RollOver.png"),loadImage("Disconnected_Base.png"))
     .plugTo( this, "CameraConnection")
     .updateSize();
     
     //Settings Button
    PaneView_GUI.addButton("CameraSetting")
     .setValue(0)
     .setPosition(pane_x+temp_pane_W,pane_y+50)
     .setSize(50,50)
     .setImages(loadImage("Settings_Base.png"),loadImage("Settings_RollOver.png"),loadImage("Settings_Base.png"))
     .plugTo( this, "CameraConnection")
     .updateSize();
     
    } // end initialUpdate
  
  
  //----------
  void update(){  
    strokeWeight(1);
    rectMode(CORNER); 
    textAlign(CENTER, CENTER);
    textSize(14);
    //Display background
    switch(flag) {
      case 0 : //Camera is not connected
        fill(100);
        stroke(0);
        strokeWeight(1);
        rectMode(CORNER); 
        rect(pane_x,pane_y,pane_W,pane_H);
        break;
      case 1 : //Camera is connected
        if (fwdCam.isAvailable()) {
          fwdCam.read(); 
          image(fwdCam,pane_x+1,pane_y+1,pane_W-2,pane_H-2);}
        else
          image(fwdCam,pane_x+1,pane_y+1,pane_W-2,pane_H-2);
        break;}  
        
    //Display framerate
    fill(200); text("FPS: "+round(frameRate),pane_x+pane_W-25,pane_y+pane_H-10);
  

  
  
 ArtificalHorrizon1.AHdisplay(-10,5,0,0,0);
 temp_heading = temp_heading+1;
 Compass1.headingdisplay(45,1,0);
 Depth1.DepthDisplay(25,50,27);

   



} //end update
  
  
  
//----------
  void CameraConnection() {
    if (flag == 0){fwdCam.start(); println("started camera");flag = 1;}
    else{fwdCam.stop(); println("started stopped"); flag = 0;}}//end CameraConnection
  
//----------
  void CameraSetting() {
    if (flag == 0){fwdCam.start();println("started camera");flag = 1;}
    else{fwdCam.stop();println("started stopped");flag = 0;}
  }//end CameraSetting
  
//----------

    
//----------
  
  
//----------  
  
}//end class
