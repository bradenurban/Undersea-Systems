class Pane_View {
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


  Pane_View() {
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
      fill(100);
      rect(pane_x, pane_y, pane_W, pane_H);
      print("initial update");

    } // end initialUpdate


    //----------
    StringDict update(StringDict Status) {  
      
      
      strokeWeight(1);
      rectMode(CORNER); 
      textAlign(CENTER, CENTER);
      textSize(14);
      //Display background
      switch(Status.get("FwdCamState")) {
      case "Off" : //Camera is not connected
        fill(100);
        stroke(0);
        strokeWeight(1);
        rectMode(CORNER); 
        rect(pane_x, pane_y, pane_W, pane_H);
        break;
      case "On" : //Camera is connected
        if (fwdCam.isAvailable()) {
          fwdCam.read(); 
          image(fwdCam, pane_x+1, pane_y+1, pane_W-2, pane_H-2);
        } else
          image(fwdCam, pane_x+1, pane_y+1, pane_W-2, pane_H-2);
        break;
      }  

      //Display framerate
      fill(200); 
      text("FPS: "+round(frameRate), pane_x+pane_W-25, pane_y+pane_H-10);


    return Status;
    } //end update



    //----------
    void CameraConnection() {
      if (flag == 0) {
        VC_Client.publish("USS/TS/VC/FwdCamControl", "CamStart");
        delay(2);
        fwdCam.start(); 
        println("started camera");
        flag = 1;
      } else {
        VC_Client.publish("USS/TS/VC/FwdCamControl", "CamEnd");
        delay(2);
        fwdCam.stop(); 
        println("Stopped Camera"); 
        flag = 0;
      }
    }//end CameraConnection

    //----------
    void CameraSetting() {
      if (flag == 0) {
        fwdCam.start();
        println("started camera");
        flag = 1;
      } else {
        fwdCam.stop();
        println("started stopped");
        flag = 0;
      }
    }//end CameraSetting

    //----------
    void ScreenGrab() {
    }//end ScreenGrab

    //----------


    //----------
  }//end class
