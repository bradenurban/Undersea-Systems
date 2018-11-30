class Pane_Gauges {
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
  int GuageConfig;

  color textColor = #0AE300;



  Pane_Gauges() {
    flag = 0;
  }

  public void bar(int n) {
    println("button pressed:", n);
  }//end void



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
    fill(0);
    rect(pane_x, pane_y, pane_W, pane_H);

    //ConfigList
    String[] TopicList = {"1X1 Gauge", "1X2 Gauge", "2x2 Gauge", "1X3 Gauge", "2X3 Gauge"};

    //button bar
    ButtonBar b = Pane_GUI.addButtonBar("GaugeOptions")
      .setPosition(zero_x, zero_y)
      .setSize(pane_W, 20)
      .addItems(TopicList);
    b.onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent ev) {
        ButtonBar bar = (ButtonBar)ev.getController();
        GuageConfig = bar.hover();
      }
    }
    );
  } // end initialUpdate


  StringDict update(StringDict Status, IntDict Attitude) {
    fill(0);
    rect(pane_x, pane_y, pane_W, pane_H);
    println(GuageConfig);
    switch(GuageConfig) {
    case 0: //1x1

    case 1: //1x2


    case 2: //2x2

    case 3: //1x3


    case 4: //2x3


      //}//End switch
      return Status;
    }//end PaneGauges Update function


    //Class 2x3-------------------------------------------------------------

    class config_2x3 {
      int 2x3_pane_x;
      int 2x3_pane_y;
      int 2x3_pane_W;
      int 2x3_pane_H;
      int 2x3_center_x;
      int 2x3_center_y;
      int 2x3_zero_y;
      int 2x3_zero_x;
      int 2x3_end_y;
      int 2x3_end_x;

      //Delcare classes here
      1_config_2x3 Gauge1 = new 1_config_2x3();

      config_2x3() {
      }
      void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
        2x3_pane_x= temp_pane_x;
        2x3_pane_y= temp_pane_y;
        2x3_pane_W= temp_pane_W;
        2x3_pane_H= temp_pane_H-20;
        2x3_center_x = 2x3_pane_x+(2x3_pane_W/2);
        2x3_center_y = 2x3_pane_y+(2x3_pane_H/2)-20; //minus 20 for bar selection
        2x3_zero_y = 2x3_pane_y;
        2x3_zero_x = 2x3_pane_x;
        2x3_end_y = temp_pane_y+temp_pane_H;
        2x3_end_x = temp_pane_x+temp_pane_W;
        
        Gauge1.initialSetup(2x3_zero_x,2x3_zero_y,2x3_pane_W,2x3_pane_H/3);
        
      }//end 2x3 initial setup


      void update(StringDict Status, IntDict Attitude) {
        
        
      }//end 2x3 update


      class 1_config_2x3 {
        int 1_2x3_pane_x;
        int 1_2x3_pane_y;
        int 1_2x3_pane_W;
        int 1_2x3_pane_H;
        int 1_2x3_center_x;
        int 1_2x3_center_y;
        int 1_2x3_zero_y;
        int 1_2x3_zero_x;
        int 1_2x3_end_y;
        int 1_2x3_end_x;

        1_config_2x3() {
        }
        void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
          1_2x3_pane_x= temp_pane_x;
          1_2x3_pane_y= temp_pane_y;
          1_2x3_pane_W= temp_pane_W;
          1_2x3_pane_H= temp_pane_H;
          1_2x3_center_x = 1_2x3_pane_x+(2x3_pane_W/2);
          1_2x3_center_y = 1_2x3_pane_y+(2x3_pane_H/2);
          1_2x3_zero_y = 2x3_pane_y;
          1_2x3_zero_x = 2x3_pane_x;
          1_2x3_end_y = temp_pane_y+temp_pane_H;
          1_2x3_end_x = temp_pane_x+temp_pane_W;
        }//end 1-2x3 initial setup


        void update(StringDict Status, IntDict Attitude) {
          fill(0);
          stroke(255);
          rect(1_2x3_zero_x,1_2x3_zero_
        
        
        }//end 1-2x3 update
      }//end 1-config 2x3
    }
