

import SubSeaUtilites
import time

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
W = 640
H = 480
FrameRate = 60
Port = 9000
prev_heartbeat = 0
pulse = 3
#--------------------------------------------------------


print(state)


   
#--------------------------------------------------------

while error == 0:
    #Setup and load on the config files---------------------
    if mode == "StartUp" :
        #--------------------------------------       
        print("Loading Config..")
        fwdCam = SubSeaUtilites.loadConfig(r"C:\Users\Braden\Documents\GitHub\Undersea-Systems\Undersea Systems\99 - Development\Config Files\Config_FwdCamera.txt")
        state["config"] = "Loaded"
        print("Config Loaded")
        #--------------------------------------
        print("Starting Log...")
        FC_log = SubSeaUtilites.SSLog()
        logTitle = FC_log.creatLog("TestLog")
        state["log"] = FC_log.State
        print("Log Started")
        #--------------------------------------
        print("Starting MQTT...")
        FC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle)
        FC_mqttc.run()
        state["mqtt"] = FC_mqttc.state     
        print("MQTT Started")
        #-----------------------
    
    
    elif mode == "LoadConfig" : 
        
        print("Loading Config..")
        fwdCam = SubSeaUtilites.loadConfig(r"C:\Users\Braden\Documents\GitHub\Undersea-Systems\Undersea Systems\99 - Development\Config Files\Config_FwdCamera.txt")
        
        print("Config Loaded")
        state["config"] = "Loaded"
        
        
    elif mode == "CreateLog":

        #--------------------------------------
        print("Starting Log...")
        #--------------------------------------
        
        FC_log = SubSeaUtilites.SSLog()
        logTitle = FC_log.creatLog("TestLog")
        state["log"] = FC_log.State
        
        #--------------------------------------
        print("Log Started")
        #--------------------------------------
        
    elif mode =="StartMQTT" :
        
        #-----------------------------
        print("Starting MQTT...")
        #---------------------
       
        FC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle)
        FC_mqttc.run()
        state["mqtt"] = FC_mqttc.state
        
        #-----------------------      
        print("MQTT Started")
        #-----------------------

        
    elif mode == "CamStart": #Start the Camera Service
        
        #-----------------------
        print("Starting Camera")
        #-----------------------
        
        FC_camera = SubSeaUtilites.SSCamera(logTitle)
        FC_camera.camStart(W, H, FrameRate, Port)
 
        #-----------------------
        print("Camera Started")
        #-----------------------
        

    elif mode == "camEnd":
        
        #-----------------------
        print("Starting Camera")
        #-----------------------
        
        FC_camera.camEnd()
        
        #-----------------------
        print("Camera Started")
        #-----------------------
        
    elif mode == "Heartbeat":  
        
        if  time.time()-prev_heartbeat >= 3:
            
            #-----------------------
            print("Heartbeat")
            #---------------------
           
            FC_mqttc.sendMessage("USS/SS/FwdCam/HeartBeat","HeartBeat")
            prev_heartbeat = time.time()
   
    
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

      
        
        
        
        
        
        
        
        
        
        
        
        
        