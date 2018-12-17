#! /usr/bin/python3
import SubSeaUtilites
import time
import os
dirname = os.path.dirname(__file__)
configFilename = os.path.join(dirname,"CC_Config.txt")
#Declare Variables

newMode = "hello"
mode = "StartUp"

state = {"config":  "NotLoaded",
         "mqtt":    "NotStarted",
         "log":     "NotStarted",
         "Cam":     "NotStarted"}

attitude = {"pitch":    0,
            "roll":     0,
            "heading":  0,
            "surge":    0,
            "heave":    0,
            "sway":     0,
            "sysCal":   0,
            "aclCal":   0,
            "gyrCal":   0,}

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
        CC_log = SubSeaUtilites.SSLog()
        logTitle = CC_log.creatLog(config["CanName"])
        state["log"] = CC_log.State
        print("Log Started")
        #--------------------------------------
        print("Starting MQTT...")
        CC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle,config["MQTT_IP"],config["CanName"])
        CC_mqttc.run()
        state["mqtt"] = CC_mqttc.state     
        print(state["mqtt"])
        #--------------------------------------
        print("Starting SerialIMU...")
        print(config["SerialIMU_port"])
        CC_serialIMU = SubSeaUtilites.SerialIMU(logTitle,config["SerialIMU_port"],config["SerialIMU_baud"])
        CC_serialIMU.run()
        state["serialIMU"] = CC_serialIMU.state    
        print(state["serialIMU"])
        #-----------------------
        print("Starting health functions...")
        CC_health = SubSeaUtilites.Health(logTitle)
        #-----------------------
    
    elif mode == "LoadConfig" : 
        
        print("Loading Config..")
        config = SubSeaUtilites.loadConfig(configFilename)
        print("Config Loaded")
        state["config"] = "Loaded"
        
        
    elif mode == "CreateLog":

        #--------------------------------------
        print("Starting Log...")
        CC_log = SubSeaUtilites.SSLog()
        logTitle = CC_log.creatLog("TestLog")
        state["log"] = CC_log.State
        print("Log Started")
        #--------------------------------------
        
    elif mode =="StartMQTT" :
        
        #-----------------------------
        print("Starting MQTT...")
        CC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle,config["MQTT_IP"],config["CanName"])
        CC_mqttc.run()
        state["mqtt"] = CC_mqttc.state    
        print(state["mqtt"])
        #-----------------------

        
    elif mode == "StartSerialIMU":
        
        #-----------------------------
        print("Starting SerialIMU...")
        CC_serialIMU = SubSeaUtilites.SerialIMU(logTitle,config["SerialIMU_port"],config["SerialIMU_baud"])
        CC_serialIMU.run()
        state["serialIMU"] = CC_serialIMU.state    
        print(state["serialIMU"])
        #-----------------------

    
    elif mode == "Heartbeat":  
        
        
        if  time.time()-prev_heartbeat >= int(config["Heartbeat_pulse"]):
        #---------------------
            if state["mqtt"]!="NotStarted":
                print("Heatrbeat - MQTT")
                #find cpu temp-------------------------
                #health_cpuTemp = CC_health.cpuTemp()
                health_cpuTemp = "65"
                
                #find ambient temp-------------------------
                health_ambTemp = "27"
                
                #find cpu usage-------------------------
                health_cpuUsuage = str(CC_health.cpuPercent())
                
                #Find MQTT STate-------------------------
                health_MQTTState = state["mqtt"]
                
                #Find Log State--------------------------
                health_LogState = state["log"]
                
                #Find Camera State--------------------------
                health_CamState = state["Cam"]
                
                #Find Mode---------------------------------
                health_Mode = mode
                
                #find leak---------------------------------
                health_Leak = "no"
                
                #combine everything-------------------
                health_message = health_cpuTemp + "," + health_ambTemp +","+ health_cpuUsuage + "," + health_MQTTState + "," +  health_LogState + "," + health_CamState  + "," + health_Mode  + "," + health_Leak
                
                #send MQTT-------------------------
                CC_mqttc.sendMessage("USS/SS/CtrCam/Health",health_message)
                prev_heartbeat = time.time()
                
            
            else: 
                print("Pulse")
                CC_log.record(logTitle, "Heartbeat", "Heartbeat", "Pulse")
   
        
        #print(prev_heartbeat)
    #Mode Changes----------------------------
    
    
    if state["config"] == "NotLoaded":
        prev_mode = str(mode);
        mode = "LoadConfig"   
   
    elif state["log"] == "NotStarted": 
        mode = "CreateLog" 

    elif state["mqtt"] == "NotStarted":
        time.sleep(2)
        mode = "StartMQTT"
    
    elif state["serial"] == "Started":
        attitude = CC_serialIMU.readIMU(attitude)
        
        
           
        print(attitude)
    
    elif mode != "Heartbeat":
        mode = "Heartbeat" 
        
    
    try:   
        if  CC_mqttc.newModeFlag == 1:
            mode =  CC_mqttc.newMode
            CC_mqttc.newModeFlag = 0
    except:
        pass   
    #-----------------------------------

      
        
        
        
        
        
        
        
        
        
        
        
        
        