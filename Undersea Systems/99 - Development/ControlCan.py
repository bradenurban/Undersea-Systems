#! /usr/bin/python3
import SubSeaUtilites
import time
import os
import serial

dirname = os.path.dirname(__file__)
configFilename = os.path.join(dirname,"CC_Config.txt")
#Declare Variables

mode = "StartUp"

state = {"config":  "NotLoaded",
         "mqtt":    "NotStarted",
         "log":     "NotStarted",
         "serial":  "NotStarted"}

attitude = {"pitch":    0,
            "roll":     0,
            "heading":  0,
            "surge":    0,
            "heave":    0,
            "sway":     0,
            "sysCal":   0,
            "aclCal":   0,
            "gyrCal":   0}

error = 0

#----------Temp Variables-------------------------------
prev_heartbeat = 0

#---------------------
#----main loop--------
#---------------------

while error == 0:
    #Setup and load on the config files---------------------
    if mode == "StartUp" :
        #--------------------------------------       
        print("Loading Config..")
        config = SubSeaUtilites.loadConfig(configFilename)
        state["config"] = "Loaded"
        print(state["config"])
        #--------------------------------------
        print("Starting Log...")
        CC_log = SubSeaUtilites.SSLog()
        logTitle = CC_log.creatLog(config["CanName"])
        state["log"] = CC_log.State
        print(state["log"])
        #--------------------------------------
        print("Starting MQTT...")
        CC_mqttc = SubSeaUtilites.SSMQTTClass(logTitle,config["MQTT_IP"],config["CanName"])
        CC_mqttc.run()
        state["mqtt"] = CC_mqttc.state     
        print(state["mqtt"])
        #--------------------------------------
        print(config["SerialIMU_port"])
        CC_serialIMU = SubSeaUtilites.SerialIMU(logTitle)
        
        try:
            CC_log.record(logTitle, "SerialIMU", "State", "Starting at Port: "+config["SerialIMU_port"]+" at baud: "+config["SerialIMU_baud"])
            time.sleep(0.5)
            serialIMU = serial.Serial(config["SerialIMU_port"],config["SerialIMU_baud"])
            CC_log.record(logTitle, "SerialIMU", "State", "Started")
            state["serial"] = "Started"
            print("Serial Started")
        except:
            CC_log.record(logTitle, "SerialIMU", "State", "Serial Failed")
        print(state["serial"])
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
        print(config["SerialIMU_port"])
        
        try:
            CC_log.record(logTitle, "SerialIMU", "State", "Starting...")
            time.sleep(0.5)
            serialIMU = serial.Serial(config["SerialIMU_port"],config["SerialIMU_baud"])
            CC_log.record(logTitle, "SerialIMU", "State", "Started")
            state["serial"] = "Started"
            print("Serial Started")
        except:
            CC_log.record(logTitle, "SerialIMU", "State", "Serial Failed")
            
        print(state["serialIMU"])
        #-----------------------
    
    elif mode == "Heartbeat":  
        if  time.time()-prev_heartbeat >= int(config["Heartbeat_pulse"]):
        #---------------------
            if state["mqtt"]!="NotStarted":
                print("Heatrbeat - MQTT")
                #find cpu temp-------------------------
                health_cpuTemp = CC_health.cpuTemp()
                #health_cpuTemp = "65"
                
                #find ambient temp-------------------------
                health_ambTemp = "27"
                
                #find cpu usage-------------------------
                health_cpuUsuage = str(CC_health.cpuPercent())
                
                #Find MQTT STate-------------------------
                health_MQTTState = state["mqtt"]
                
                #Find Log State--------------------------
                health_LogState = state["log"]
                
                #Find serial State--------------------------
                health_CamState = state["serial"]
                
                #Find Mode---------------------------------
                health_Mode = mode
                
                #find leak---------------------------------
                health_Leak = "no"
                
                #combine everything-------------------
                health_message = health_cpuTemp + "," + health_ambTemp +","+ health_cpuUsuage + "," + health_MQTTState + "," +  health_LogState + "," + health_CamState  + "," + health_Mode  + "," + health_Leak
                
                #send MQTT-------------------------
                CC_mqttc.sendMessage("USS/SS/CtrCan/Health",health_message)
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
        time.sleep(1)
        mode = "StartMQTT"
    
    #read and update serial data
    elif state["serial"] == "NotStarted":
        mode = "StartSerialIMU"
    
    else:
        mode = "Heartbeat" 
        
    try:   
        if  CC_mqttc.newModeFlag == 1:
            mode =  CC_mqttc.newMode
            CC_mqttc.newModeFlag = 0
    except:
        pass   
	    
    try:
        while serialIMU.in_waiting > 30:
            temp_data = str(serialIMU.readline()).replace("b'","").replace("\\r\\n", "").replace("'","")
            attitude = CC_serialIMU.parseData(temp_data,attitude)
            CC_mqttc.sendMessage("USS/SS/CtrCan/IMU",temp_data)

    except:
        print("Serial Error")
        time.sleep(3)

#-----------------------------------

print("loop")
      
        
        
        
        
        
        
        
        
        
        
        
        
        