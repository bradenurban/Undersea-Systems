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
  Widgits Widgits_2x3 = new Widgits();
  config_2x3 config_2x3_1 = new config_2x3();
  Pane_Gauges() {
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
    

    config_2x3_1.initialSetup(pane_x, pane_y+21, pane_W, pane_H-20);

    GuageConfig = 0;
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
    //println(GuageConfig);
    //switch(GuageConfig) {
    //case 0: //1x1
    //  break;
    //case 1: //1x2
    //  break;
    //case 2: //2x2
    //  break;
    //case 3: //1x3
    //  break;
    //case 4: //2x3
    config_2x3_1.update(Status, Attitude);
    //  break;
    //}//End switch


    return Status;
  }//end PaneGauges Update function


  //Class 2x3-------------------------------------------------------------

  class config_2x3 {
    int pane_x_2x3;
    int pane_y_2x3;
    int pane_W_2x3;
    int pane_H_2x3;
    int center_x_2x3;
    int center_y_2x3;
    int zero_y_2x3;
    int zero_x_2x3;
    int end_y_2x3;
    int end_x_2x3;

    String[] internalGaugeConfig = new String[8];


    gauge gauge1 = new gauge();
    gauge gauge2 = new gauge();
    gauge gauge3 = new gauge();
    gauge gauge4 = new gauge();
    gauge gauge5 = new gauge();
    gauge gauge6 = new gauge();
    //Delcare classes here

    config_2x3() {
    }
    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      pane_x_2x3 = temp_pane_x;
      pane_y_2x3 = temp_pane_y;
      pane_W_2x3 = temp_pane_W;
      pane_H_2x3= temp_pane_H-20;
      center_x_2x3 = pane_x_2x3+(pane_W_2x3/2);
      center_y_2x3 = pane_y_2x3+(pane_H_2x3/2)+20; //minus 20 for bar selection
      zero_y_2x3 = pane_y_2x3;
      zero_x_2x3 = pane_x_2x3;
      end_y_2x3 = temp_pane_y+temp_pane_H;
      end_x_2x3 = temp_pane_x+temp_pane_W;

      gauge1.initialSetup("1", pane_x_2x3 + (pane_W_2x3/2)*0, pane_y_2x3 + (pane_H_2x3/3)*0, pane_W_2x3/2, pane_H_2x3/3);
      gauge2.initialSetup("2", pane_x_2x3 + (pane_W_2x3/2)*1, pane_y_2x3 + (pane_H_2x3/3)*0, pane_W_2x3/2, pane_H_2x3/3);
      gauge3.initialSetup("3", pane_x_2x3 + (pane_W_2x3/2)*0, pane_y_2x3 + (pane_H_2x3/3)*1, pane_W_2x3/2, pane_H_2x3/3);
      gauge4.initialSetup("4", pane_x_2x3 + (pane_W_2x3/2)*1, pane_y_2x3 + (pane_H_2x3/3)*1, pane_W_2x3/2, pane_H_2x3/3);
      gauge5.initialSetup("5", pane_x_2x3 + (pane_W_2x3/2)*0, pane_y_2x3 + (pane_H_2x3/3)*2, pane_W_2x3/2, pane_H_2x3/3);
      gauge6.initialSetup("6", pane_x_2x3 + (pane_W_2x3/2)*1, pane_y_2x3 + (pane_H_2x3/3)*2, pane_W_2x3/2, pane_H_2x3/3);

      internalGaugeConfig[0] = "null";
      internalGaugeConfig[1] = "null";
      internalGaugeConfig[2] = "null";
      internalGaugeConfig[3] = "null";
      internalGaugeConfig[4] = "null";
      internalGaugeConfig[5] = "null";
      internalGaugeConfig[6] = "null";
      internalGaugeConfig[7] = "null";
    
  }//end 2x3 initial setup


    void update(StringDict Status, IntDict Attitude) {
      gauge1.update(Status, Attitude);
      gauge2.update(Status, Attitude);
      gauge3.update(Status, Attitude);
      gauge4.update(Status, Attitude);
      gauge5.update(Status, Attitude);
      gauge6.update(Status, Attitude);

      println(internalGaugeConfig);
    }//end 2x3 update

    class gauge {
      int g_pane_x;
      int g_pane_y;
      int g_pane_W;
      int g_pane_H;
      int g_center_x;
      int g_center_y;
      int g_zero_y;
      int g_zero_x;
      int g_end_y;
      int g_end_x;
      String GaugeNumber;

      //Delcare classes here

      gauge() {
      }
      void initialSetup(String temp_GaugeNumber, int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
        g_pane_x = temp_pane_x;
        g_pane_y = temp_pane_y;
        g_pane_W = temp_pane_W;
        g_pane_H = temp_pane_H;
        g_center_x = g_pane_x+(g_pane_W/2);
        g_center_y = g_pane_y+(g_pane_H/2);
        g_zero_y = g_pane_y;
        g_zero_x = g_pane_x;
        g_end_y = temp_pane_y+temp_pane_H;
        g_end_x = temp_pane_x+temp_pane_W;
        GaugeNumber = temp_GaugeNumber;
        
        //setup widgits
        //Widgits_2x3.initialSetup(g_pane_x,g_pane_y,g_pane_W,g_pane_H);

        //button bar
        Pane_GUI.addButton(GaugeNumber+"Guage"+"Lights")
          .setLabel("Lights")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 0*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
        Pane_GUI.addButton(GaugeNumber+"Guage"+"Compass")
          .setLabel("Compass")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 1*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
        Pane_GUI.addButton(GaugeNumber+"Guage"+"Thruster")
          .setLabel("Thrusters")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 2*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
        Pane_GUI.addButton(GaugeNumber+"Guage"+"Force")
          .setLabel("Forces")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 3*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
        Pane_GUI.addButton(GaugeNumber+"Guage"+"TOI")
          .setLabel("TOI")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 4*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
        Pane_GUI.addButton(GaugeNumber+"Guage"+"Chart")
          .setLabel("Chart")
          .setValue(0)
          .setPosition((g_zero_x+1)+ 5*(g_pane_W-2)/6, g_end_y-20)
          .setSize((g_pane_W-2)/6, 20)
          .plugTo(this, "Test");
        ;
      }

      void update(StringDict Status, IntDict Attitude) {

        fill(0);
        stroke(255);
        rect(g_pane_x, g_pane_y, g_pane_W, g_pane_H);
        switch(internalGaugeConfig[int(GaugeNumber)]){
         case "null":
         break;
          case "Lights":
           Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
        case "Compass":
          Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
        case "Thrusters":
          Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
        case "Forces":
          Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
        case "TOI":
          Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
        case "Chart":
          Widgits_2x3.Lights(g_pane_x,g_pane_y,g_pane_W,g_pane_H-20);
          break;
          
          
          
        }//end switch
        
      }//end gauge update

      void Test() {
      }
      void controlEvent(ControlEvent theEvent) {
        String name = theEvent.getName();
        int index = int(str(name.charAt(0)));
        String type = name.substring(6, name.length());
        println(type);
        switch(type) {
        case "Lights":
          println(index);
          internalGaugeConfig[index]="Lights";
          break;
        case "Compass":
          println(index);
          internalGaugeConfig[index]="Compass";
          break;
        case "Thrusters":
          println(index);
          internalGaugeConfig[index]="Thrusters";
          break;
        case "Forces":
          println(index);
          internalGaugeConfig[index]="Forces";
          break;
        case "TOI":
          println(index);
          internalGaugeConfig[index]="TOI";
          break;
        case "Chart":
          println(index);
          internalGaugeConfig[index]="Chart";
          break;
        }//end switch
      }//end gauge class
    }//end lights
  }//end config 2x3
}//end main class