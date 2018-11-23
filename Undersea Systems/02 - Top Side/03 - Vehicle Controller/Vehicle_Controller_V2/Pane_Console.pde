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
  color textColor = #0AE300;

  VC_Console VC_Console1 = new VC_Console();
  MQTT_Pub MQTT_Pub1 = new MQTT_Pub();

  Pane_Console() {
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

    //Console Panes
    VC_Console1.initialSetup(zero_x, zero_y, pane_W/4, pane_H);
    MQTT_Pub1.initialSetup(zero_x+pane_W/4, zero_y, pane_W/4, pane_H);
  } // end initialUpdate


  StringDict update(StringDict Status) {
    Status = VC_Console1.update(Status);
    Status = MQTT_Pub1.update(Status);
    return Status;
  }//end update


  //---------------------------------------------------------------------
  class VC_Console {
    int VC_pane_x;
    int VC_pane_y;
    int VC_pane_W;
    int VC_pane_H;
    int VC_center_x;
    int VC_center_y;
    int VC_zero_y;
    int VC_zero_x;
    int VC_end_y;
    int VC_end_x;

    color textColor = #0AE300;
    color background = #323232;
    color accent = #002D5A;
    color button_text = #E5E5E5;

    PFont ConsoleFont;

    Textarea console_VC;
    Println console;

    VC_Console() {
      ;
    }
    void initialSetup(int temp_pane_x, int temp_pane_y,int temp_pane_W, int temp_pane_H) {
      VC_pane_x= temp_pane_x;
      VC_pane_y= temp_pane_y;
      VC_pane_W= temp_pane_W;
      VC_pane_H= temp_pane_H;
      VC_center_x = VC_pane_x+(VC_pane_W/2);
      VC_center_y = VC_pane_y+(VC_pane_H/2);
      VC_zero_y = VC_pane_y;
      VC_zero_x = VC_pane_x;
      VC_end_y = temp_pane_y;
      VC_end_x = temp_pane_x;

      Pane_GUI.enableShortcuts();
      ConsoleFont = createFont("Yu Gothic UI Bold", 12);
      textFont(ConsoleFont);
      textSize(1);
      textAlign(LEFT, CENTER);
      text("Vehicle Controller Console", VC_zero_x, 7);

      stroke(0);
      strokeWeight(1);

      Pane_GUI.addButton("Pause")
        .setValue(0)
        .setPosition(VC_zero_x, VC_zero_y+15)
        .setSize(VC_pane_W/3, 15)
        .plugTo( this, "VCPause");

      Pane_GUI.addButton("Play")
        .setValue(0)
        .setPosition(VC_zero_x+(VC_pane_W/3)+1, VC_zero_y+15)
        .setSize(VC_pane_W/3, 15)
        .plugTo( this, "VCPlay");

      Pane_GUI.addButton("Clear")
        .setValue(0)
        .setPosition(VC_zero_x+2*(VC_pane_W/3)+2, VC_zero_y+15)
        .setSize(VC_pane_W/3, 15)
        .plugTo( this, "VCClear");

      console_VC = Pane_GUI.addTextarea("txt")
        .setPosition(VC_zero_x, VC_zero_y+30)
        .setSize(VC_pane_W, VC_pane_H-30)
        .setFont(createFont("arial", 12))
        .setLineHeight(10)
        .setColor(color(150))
        .setColorBackground(color(0));
      //.setColorForeground(color(255, 100)); 

      console = Pane_GUI.addConsole(console_VC);
    }//end INITIAL SETUP

    void VCPause() {
      console.pause();
    }
    void VCPlay() {
      console.play();
    }
    void VCClear() {
      console.clear();
    }

    StringDict update(StringDict Status) {
      fill(accent);
      noStroke();
      rect(VC_zero_x, VC_zero_y, VC_pane_W, 14);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(12);
      textAlign(CENTER, CENTER);
      text("VC CONSOLE", VC_center_x, VC_zero_y+5);

      strokeWeight(1);
      return Status;
    }//end update
  }//END VC CLASS

  //---------------------------------------------------------------------
  class MQTT_Pub {
    int MP_pane_x;
    int MP_pane_y;
    int MP_pane_W;
    int MP_pane_H;
    int MP_center_x;
    int MP_center_y;
    int MP_zero_y;
    int MP_zero_x;
    int MP_end_y;
    int MP_end_x;

    color textColor = #0AE300;
    color background = #323232;
    color accent = #002D5A;
    color button_text = #E5E5E5;
    PFont ConsoleFont;
    Textfield mqtt_input;
    Textarea mqtt_history;

    MQTT_Pub() {
      ;
    }
    void initialSetup(int temp_pane_x, int temp_pane_y, int temp_pane_W, int temp_pane_H) {
      MP_pane_x= temp_pane_x;
      MP_pane_y= temp_pane_y;
      MP_pane_W= temp_pane_W;
      MP_pane_H= temp_pane_H;
      MP_center_x = MP_pane_x+(MP_pane_W/2);
      MP_center_y = MP_pane_y+(MP_pane_H/2);
      MP_zero_y = MP_pane_y;
      MP_zero_x = MP_pane_x;
      MP_end_y = temp_pane_y;
      MP_end_x = temp_pane_x;


      ConsoleFont = createFont("Yu Gothic UI Bold", 12);
      textFont(ConsoleFont);
      textSize(1);
      textAlign(LEFT, CENTER);

      mqtt_history = Pane_GUI.addTextarea("mqtt_history")
        .setPosition(MP_zero_x+1, MP_zero_y+82)
        .setSize(MP_pane_W, MP_pane_H-82-1)
        .setFont(createFont("arial", 12))
        .setLineHeight(10)
        .setColor(color(150))
        .setColorBackground(color(0));

      mqtt_input = Pane_GUI.addTextfield("MQTT_TOPIC")
        .setPosition(MP_zero_x+55, MP_zero_y+15)
        .setSize(MP_pane_W-55-1, 15)
        .setFont(ConsoleFont)
        .setLabel("")
        ;

      mqtt_input = Pane_GUI.addTextfield("MQTT_MSG")
        .setPosition(MP_zero_x+55, MP_zero_y+31)
        .setSize(MP_pane_W-55-1, 15)
        .setFont(ConsoleFont)
        .setLabel("")
        ;
        
      Pane_GUI.addButton("SEND")
        .setValue(0)
        .setPosition(MP_zero_x+1, MP_zero_y+50)
        .setSize(MP_pane_W, 25)
        .plugTo( this, "MQTT_Send");
        
    }//end INITIAL SETUP

    void MQTT_Send(){
      String Topic = Pane_GUI.get(Textfield.class,"MQTT_TOPIC").getText();
      String MSG = Pane_GUI.get(Textfield.class,"MQTT_MSG").getText();
      VC_Client.publish(Topic, MSG);
      //VC_Client.publish("USS/TS/VC/FwdCamControl", "CamEnd");
      mqtt_history.append("MQTT Pub: "+Topic+" : " + MSG + "\n");
    }

    StringDict update(StringDict Status) {
      fill(accent);
      noStroke();
      rectMode(CORNER);
      rect(MP_zero_x, MP_zero_y, MP_pane_W, 14);

      fill(button_text);
      textFont(createFont("Yu Gothic UI Bold", 12));
      textSize(12);
      textAlign(CENTER, CENTER);
      text("MQTT PUBLISH", MP_center_x, MP_zero_y+5);

      fill(accent);
      rectMode(CORNER);
      rect(MP_zero_x+1, MP_zero_y+15, 50, 15);
      textSize(10);
      fill(button_text);
      textAlign(CORNER, CENTER);
      text("TOPIC:", MP_zero_x+3, MP_zero_y+20);

      fill(accent);
      rectMode(CORNER);
      rect(MP_zero_x+1, MP_zero_y+31, 50, 15);
      textSize(10);
      fill(button_text);
      textAlign(CORNER, CENTER);
      text("MESSAGE:", MP_zero_x+3, MP_zero_y+36);

      stroke(0);
      strokeWeight(1);
      return Status;
    }//end update
  }//END VC CLASS
}//end class
