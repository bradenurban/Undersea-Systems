

import SubSeaUtilites
import time
import os
dirname = os.path.dirname(__file__)
configFilename = os.path.join(dirname,"Config.txt")
#Declare Variables

newMode = "hello"
mode = "StartUp"

state = {"config":  "NotLoaded",
         "mqtt":    "NotStarted",
         "log":     "NotStarted",
         "Cam":     "NotStarted"}

error = 0

#-------------------------------------------------------
#----------Temp Variables-------------------------------
prev_heartbeat = 0
#--------------------------------------------------------

   
#--------------------------------------------------------

while error == 0:
    #Setup and load on the config files---------------------
    if mode == "StartUp" :
        #--------------------------------------       
        print("Loading Config..")
        
        config = SubSeaUtilites.loadConfig(configFilename)
        state["config"] = "Loaded"
        print("Config Loaded")
    
        #--------------------------------------
        print("Starting Log...")
        FC_log = SubSeaUtilites.SSLog()
        logTitle = FC_log.creatLog(config["CanName"])
        state["log"] = FC_log.State
        print("Log Started")
        #--------------------------------------
        print("Starting MQTT...")
        FC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle,config["MQTT_IP"],config["CanName"])
        FC_mqttc.run()
        state["mqtt"] = FC_mqttc.state     
        print(state["mqtt"])
        #-----------------------
    
    
    elif mode == "LoadConfig" : 
        
        print("Loading Config..")
        config = SubSeaUtilites.loadConfig(configFilename)
        print("Config Loaded")
        state["config"] = "Loaded"
        
        
    elif mode == "CreateLog":

        #--------------------------------------
        print("Starting Log...")
        FC_log = SubSeaUtilites.SSLog()
        logTitle = FC_log.creatLog("TestLog")
        state["log"] = FC_log.State
        print("Log Started")
        #--------------------------------------
        
    elif mode =="StartMQTT" :
        
        #-----------------------------
        print("Starting MQTT...")
        FC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle,config["MQTT_IP"],config["CanName"])
        FC_mqttc.run()
        state["mqtt"] = FC_mqttc.state    
        print(state["mqtt"])
        #-----------------------

        
    elif mode == "CamStart": #Start the Camera Service
        
        #-----------------------
        print("Starting Camera")
        FC_camera = SubSeaUtilites.SSCamera(logTitle)
        FC_camera.camStart(W, H, FrameRate, Port)
        print("Camera Started")
        #-----------------------
        

    elif mode == "camEnd":
        
        #-----------------------
        print("Starting Camera")
        FC_camera.camEnd()
        print("Camera Started")
        #-----------------------
        
    elif mode == "Heartbeat":  
        
        if  time.time()-prev_heartbeat >= int(config["Heartbeat_pulse"]):
        #---------------------
            if state["mqtt"]=="Started":
                FC_mqttc.sendMessage("USS/SS/FwdCam/HeartBeat","Pulse")
                prev_heartbeat = time.time()
            else: 
                print("Pulse")
                FC_log.record(logTitle, "Heartbeat", "Heartbeat", "Pulse")
   
        prev_heartbeat = time.time()
        
    #Mode Changes----------------------------
    
    print(state)
    
    if state["config"] == "NotLoaded":
        prev_mode = str(mode);
        mode = "LoadConfig"   
   
    elif state["log"] == "NotStarted": 
        mode = "CreateLog" 

    elif state["mqtt"] == "NotStarted":
        mode = "StartMQTT"
    
    elif mode != "Heartbeat":
        mode = "Heartbeat" 
        
    
    try:   
        if  FC_mqttc.newModeFlag == 1:
            mode =  FC_mqttc.newMode
            FC_mqttc.newModeFlag = 0
    except:
        pass   
    #-----------------------------------

      
        
        
        
        
        
        
        
        
        
        
        
        
        