class PaneView {
  int pane_x;
  int pane_y;
  int pane_W;
  int pane_H;
  
  PaneView(){
   cp5.addButton("CameraConnection")
     .setPosition(175,275)
     .setImages(loadImage("Arrow-Left.png"), loadImage("Arrow-Right.png"), loadImage("Refresh.png"))
     .updateSize();
  
  
  }
  
  
  
 //Class Functions--------------------------------------- 
  void initialUpdate(int temp_pane_x,int temp_pane_y, int temp_pane_W,int temp_pane_H){
    pane_x = temp_pane_x;
    pane_y = temp_pane_y;
    pane_W = temp_pane_W;
    pane_H = temp_pane_H;
    
    //Inital Fill
    fill(100);
    rect(pane_x,pane_y,pane_W,pane_H);
    print("initial update");
    
   public void controlEvent(ControlEvent theEvent) {
      println(theEvent.getController().getName());
    }//end control event  
    
  public void buttonA(int theValue) {
    println("a button event from buttonA: "+theValue);
  }//end buttona
    
    
    
    
    } // end initialUpdate
  
  void update(int temp_roll, 
              int temp_pitch, 
              int temp_heading, 
              int temp_depth,
              int temp_headingTarget){

  
              
              
              } //end update
  
  
  
  void
  
  
}//end class
