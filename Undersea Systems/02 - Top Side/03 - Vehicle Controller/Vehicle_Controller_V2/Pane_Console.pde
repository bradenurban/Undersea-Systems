class Pane_Console {
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

  int flag;
  
  color textColor = #0AE300;


  Pane_Console() {
    flag = 0;

  }
    //Class Functions--------------------------------------- 
    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      pane_x= temp_pane_x;
      pane_y= temp_pane_y;
      pane_W= temp_pane_W;
      pane_H= temp_pane_H;
      center_x = pane_x+(pane_W/2);
      center_y = pane_y+(pane_H/2);
      zero_y = pane_y+1;
      zero_x = pane_x+1;
      end_y = temp_pane_y - 1;
      end_x = temp_pane_x - 1;
      
      
      //Inital Fill
      fill(175);
      rect(pane_x, pane_y, pane_W, pane_H);
      print("initial update");
      //Connection Button
    
    } // end initialUpdate
    

  StringDict update(StringDict Status){
    //rect(pane_x, pane_y, pane_W, pane_H);
    return Status;
    
    
    
    
    
    
  }







}
