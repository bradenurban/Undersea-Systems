#! /usr/bin/python3
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

#----------Temp Variables-------------------------------
prev_heartbeat = 0
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
        print("Starting health functions...")
        FC_health = SubSeaUtilites.health(logTitle)
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
        FC_camera.camStart(config["Camera_W"], config["Camera_H"], config["Camera_FrameRate"], config["Camera_Port"], config["Camera_Rotation"])
        print("Camera Started")
        #-----------------------
        

    elif mode == "CamEnd":
        
        #-----------------------
        print("Ending Camera")
        FC_camera.camEnd()
        print("Camera Ended")
        #-----------------------
        
    elif mode == "Heartbeat":  
        
        if  time.time()-prev_heartbeat >= int(config["Heartbeat_pulse"]):
        #---------------------
            if state["mqtt"]!="NotStarted":
                print("Heatrbeat - MQTT")
                #find cpu temp-------------------------
                #health_cpuTemp = FC_health.cpuTemp()
                health_cpuTemp = "65"
                
                #find ambient temp-------------------------
                health_ambTemp = "27"
                
                #find cpu usage-------------------------
                health_cpuUsuage = str(FC_health.cpuPercent())
                
                #Find MQTT STate-------------------------
                health_MQTTState = state["mqtt"]
                
                #Find Log State--------------------------
                health_LogState = state["log"]
                
                #Find Camera State--------------------------
                health_CamState = state["Cam"]
                
                #Find Mode--------------------------
                health_Mode = mode
                
                #find leak--------------------------
                health_Leak = "no"
                
                #combine everything-------------------
                health_message = health_cpuTemp + "," + health_ambTemp +","+ health_cpuUsuage + "," + health_MQTTState + "," +  health_LogState + "," + health_CamState  + "," + health_Mode  + "," + health_Leak
                
                #send MQTT-------------------------
                FC_mqttc.sendMessage("USS/SS/FwdCam/Health",health_message)
                prev_heartbeat = time.time()
                
                
            
            
            
            else: 
                print("Pulse")
                FC_log.record(logTitle, "Heartbeat", "Heartbeat", "Pulse")
   
        
        #print(prev_heartbeat)
    #Mode Changes----------------------------
    
    
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

      
        
        
        
        
        
        
        
        
        
        
        
        
        