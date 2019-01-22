class View_Update {
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
  float k;
  float l;
  String[] Letter = new String[4];
  String[] Number= new String[4];
  int WidgitNumber;



  View_Update() {
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
    fill(0); 
    rect(0, 0, pane_W, pane_H);

    //test cases for layout
    //noFill();
    fill(0);
    stroke(255);
    rect(0,0,(0.75)*pane_W,(0.5)*pane_H);
    
    fill(0);
    rect(0,(0.5)*pane_H,(0.5)*pane_H,(0.5)*pane_H);
    
    fill(100);
    rect((0.5)*pane_H,(0.5)*pane_H,(0.5)*pane_H,(0.5)*pane_H);

    fill(255);
    rect(pane_H,(0.5)*pane_H,(0.5)*pane_H,(0.5)*pane_H);












   return Status;
  }//end update






}//end class
