

import SubSeaUtilites
import paho.mqtt.client as mqtt #import the client1
import time
import datetime
import subprocess

#Declare Variables
mode = "Loop"

state = {"config":  "NotLoaded",
         "mqtt":    "NotStarted",
         "log":     "NotStarted",
         "Cam":     "NotStarted"}

error = 0

#-------------------------------------------------------
#----------Temp Variables-------------------------------
W = 640;
H = 480;
FrameRate = 60;
Port = 9000;

#--------------------------------------------------------
def mosquittoConnect(client, userdata, flags, rc):   
    print("Connected with result code "+str(rc))

    
def mosquittoMessage(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))
    
    
    if msg.topic == "USS/TS/VC/FwdCamControl/":
        if msg.payload == "StartCam":
            mode = "CamStart"
        elif msg.payload == "EndCam":
            mode = "CamEnd"
    
    




    
#--------------------------------------------------------
mode = "Loop"




while error == 0:
         
    mode = "loop"
  
    #Setting up All configs
    if state["config"] == "NotLoaded":
        mode = "LoadConfig"
    elif state["log"] == "NotStarted":
        mode = "CreateLog" 
    elif state["mqtt"] == "NotStarted":
        mode = "StartMQTT"
    
    
    
    #Setup and load on the config files---------------------
    if mode == "LoadConfig" :
        
        print("Loading Config..")
        fwdCam = SubSeaUtilites.loadConfig(r"C:\Users\Braden\Documents\GitHub\Undersea-Systems\Undersea Systems\99 - Development\Config Files\Config_FwdCamera.txt")
        
        print("Config Loaded")
        state["config"] = "Loaded"
        
            
    elif mode == "CreateLog":
        
        #-----------------------
        print("starting log")
        #----------------------
        
        title = ("Log_FwdCam_" + str(datetime.datetime.now().date()) + "-" +    \
                 str(datetime.datetime.now().hour)+"_"+                         \
                 str(datetime.datetime.now().minute)+"_"+                       \
                 str(datetime.datetime.now().second)+".txt")
        logStartTime = datetime.datetime.now()
        log = open(title,"w+")

        
        log.write(str(datetime.datetime.now().time())+";Log;Started\n")
        print("Log Started")
        log.close()
        state["log"] = "Started"
    
    elif mode =="StartMQTT" :
       client = SubSeaUtilites.mosquittoStart() 
       state["mqtt"] = "Started"

    
    elif mode == "CamStart": #Start the Camera Service
       
        #---------------------
        log = open(title,"a")
        print("Starting Camera")
        log.write(str(datetime.datetime.now().time()),";Camera;State;Starting Service")
        #--------------------
       
        try:
            str_Front = "sudo uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg"
            str_W = "--width " + str(W)
            str_H = "--height " + str(H)
            str_FrameRate = "--framerate " + str(FrameRate)
            str_Middle1 = "--server-option '"
            str_Port = "--port=9090'" + str(Port)
            str_End = "--server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'"
        
            shell_command = str_Front + str_W + str_H + str_FrameRate + str_Middle1 + str_Port + str_End
            subprocess.call(shell_command, shell=True)
            
        except:#Exception if service fails
            print("Camera Start Failed")
            log.write(str(datetime.datetime.now().time()),";Camera;State;Service Failed")
        
        #---------------------------
        print("Camera Started")
        log.write(str(datetime.datetime.now().time()),";Camera;State;Service Started")
        state["Cam"] = "Started"
        log.close()
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
    
    elif mode == "Loop":  
        #---------------------
        log = open(title,"a")
        print("loop")
        #---------------------
        
        SubSeaUtilites.mosquittoPublish(client, "USS/SS/FwdCam/HeartBeat","Start HeartBeat Thread")
        log.write(str(datetime.datetime.now().time())+";MQTT;Publish;USS/SS/FwdCam/HeartBeat,Start HeartBeat Thread\n")
        
        log.close
        time.sleep(5) 

