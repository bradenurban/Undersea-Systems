

import SubSeaUtilites
import time
import datetime
import subprocess

#Declare Variables
global newMode
newMode = "hello"
mode = "CreateLog"

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

    
def mosquittoMessage(client, userdata, msg):
    global mode
    global title
    global state
    topic = str(msg.topic)
    message = str(msg.payload)
    prev_mode = str(mode)
    #------------------------
    log = open(title,"a")
    print("MQTT Message From: " + topic + ": " + message)
    log.write(str(datetime.datetime.now().time())+";MQTT;Recieve;"+topic+";"+message+"\n")
    #-----------------------
    if topic == "USS/TS/VC/FwdCamControl":
        if message == "b'StartCam'":
            mode = "CamStart"
        elif message == "b'EndCam'":
            mode = "CamEnd"
        elif message == "b'LoadConfig'":
            mode = "LoadConfig"   
            state["config"] = "NotLoaded"    
    #------------------------
    log.write(str(datetime.datetime.now().time())+";Mode;Update;From "+ prev_mode+";To "+mode+"\n")
    log.close
    #------------------------

print(state)
FC_mqttc = SubSeaUtilites.SSMQTTClass()
FC_camera = SubSeaUtilites.SSCamera()
FC_log = SubSeaUtilites.SSLog("TestLog")

state["log"] = FC_log.State
print(state)
time.sleep(10)

while error == 0:
    print("Mode outside class: " + FC_mqttc.newMode)
    time.sleep(3)
   
#--------------------------------------------------------

while error == 0:
  
    #Setup and load on the config files---------------------
    if mode == "LoadConfig" : 
        
        print("Loading Config..")
        fwdCam = SubSeaUtilites.loadConfig(r"C:\Users\Braden\Documents\GitHub\Undersea-Systems\Undersea Systems\99 - Development\Config Files\Config_FwdCamera.txt")
        
        print("Config Loaded")
        state["config"] = "Loaded"
        
        
    elif mode == "CreateLog":

        print("Starting Log...")
        FC_log = SubSeaUtilites.SSLog("TestLog")
        state["log"] = FC_log.State
        print("Log Started")
        
    elif mode =="StartMQTT" :
        
        #connect to mosquitto client-----------------------------
        print("Starting MQTT...")
        FC_log.record("MQTT","State","Starting...")
        #---------------------
       
        FC_mqttc = SubSeaUtilites.SSMQTTClass()
        FC_mqttc.run()
        state["mqtt"] = FC_mqttc.state
        
        #-----------------------      
        FC_log.record("MQTT","State","Started")
        print("MQTT Started")
        #-----------------------

        
    elif mode == "CamStart": #Start the Camera Service
        #---------------------
        print("Starting Camera")
        FC_log.record("Camera","State","Starting")
        #--------------------
        

        
        #---------------------------
        print("Camera Started")

        #---------------------------
    elif mode == "camEnd":
        #---------------------
        log = open(title,"a")
        print("Ending Camera Service")
        log.write(str(datetime.datetime.now().time()),";Camera;State;Ending Service")
        #---------------------
        try:
            subprocess.call("sudo pkill uv4l", shell=True)

        except:
            print("Ending Camera Service Failed")
            log.write(str(datetime.datetime.now().time()),";Camera;State;Ending Service Failed")
        #-------------------
        print("Ending Camera")
        log.write(str(datetime.datetime.now().time()),";Camera;State;Service Ended")
        state["Cam"] = "NotStarted"
        log.close()
        #-------------------
    elif mode == "Heartbeat":  
        #---------------------
        if  time.time()-prev_heartbeat >= 3:
            log = open(title,"a")
            print("Heartbeat")
            #---------------------
            client.publish("USS/SS/FwdCam/HeartBeat","HeartBeat")
            log.write(str(datetime.datetime.now().time())+";MQTT;Publish;USS/SS/FwdCam/HeartBeat,HeartBeat\n")
            log.close
            prev_heartbeat = time.time()
   
    
    #Mode Changes----------------------------
    if state["config"] == "NotLoaded":
        log = open(title,"a")   
        prev_mode = str(mode);
        mode = "LoadConfig"
        log.write(str(datetime.datetime.now().time())+";Mode;Update;From "+ prev_mode+";To "+mode+"\n")
        log.close
    elif state["log"] == "NotStarted":
        log = open(title,"a")   
        prev_mode = str(mode);
        mode = "CreateLog" 
        log.write(str(datetime.datetime.now().time())+";Mode;Update;From "+ prev_mode+";To "+mode+"\n")
        log.close
    elif state["mqtt"] == "NotStarted":
        log = open(title,"a")   
        prev_mode = str(mode);
        mode = "StartMQTT"
        log.write(str(datetime.datetime.now().time())+";Mode;Update;From "+ prev_mode+";To "+mode+"\n")
        log.close
    elif mode != "Heartbeat":
        log = open(title,"a")   
        prev_mode = str(mode);
        mode = "Heartbeat" 
        log.write(str(datetime.datetime.now().time())+";Mode;Update;From "+ prev_mode+";To "+mode+"\n")
        log.close
    #-----------------------------------

      
        
        
        
        
        
        
        
        
        
        
        
        
        