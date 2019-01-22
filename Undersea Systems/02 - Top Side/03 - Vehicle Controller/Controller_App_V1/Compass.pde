class Compass {
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
  int diam;
  float k;
  float l;
  String[] Letter = new String[4];
  String[] Number= new String[4];
  int WidgitNumber;



  Compass() {
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
    diam = int(0.75*(end_x - pane_x));

    
  }//end initial setup


  StringDict update(StringDict Status, FloatDict Attitude) {  
    fill(0); 
    rect(pane_x, pane_y, pane_W, pane_H);
    
    fill(255);
    ellipse(center_x,center_y,diam,diam);













   return Status;
  }//end update






}//end class
