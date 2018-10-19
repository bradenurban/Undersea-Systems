

import SubSeaUtilites
import paho.mqtt.client as mqtt #import the client1
import time
import datetime
import subprocess

#Declare Variables
global mode
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


def mosquittoConnect(client, userdata, flags, rc):   
    print("Connected with result code "+str(rc))

    
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


FC_mqttc = SubSeaUtilites.SSMQTTClass()
FC_mqttc.run()


while error == 0:
    time.sleep(3)
    print("Mode outside class: " + mode)
 
    
    
    
#--------------------------------------------------------

while error == 0:
  
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
        
        #-----------------------------
        prev_state = str(state["log"])
        state["log"] = "Started"
        log.write(str(datetime.datetime.now().time())+";State;Update;From "+ prev_state+";To "+state["log"]+"\n")
        log.close()
        #----------------------------
   
    
    elif mode =="StartMQTT" :
        #connect to mosquitto client-----------------------------
        print("Starting MQTT...")
        log = open(title,"a")
        log.write(str(datetime.datetime.now().time())+";MQTT;State;Connecting to broker\n")
        #---------------------
        try:
            broker_address="192.168.1.82" #will need to replace this with variable from command file
            client = mqtt.Client("P1") #create new instance
            client.on_message = mosquittoMessage #attach function to callback
            client.connect("192.168.1.82", 1883, 60) #connect to broker
            client.loop_start() #start the loop
            #Log Entry
            print("MQTT Started...")
            log.write(str(datetime.datetime.now().time())+";MQTT;State;Broker Connected\n")
            #Start the Topics
            print("Publishing to Topics...")
            log.write(str(datetime.datetime.now().time())+";MQTT;Publish;Publishing Topics\n")
            client.publish("USS/SS/FwdCam/Command","Start Command Thread")
            client.publish("USS/SS/FwdCam/HeartBeat","Start HeartBeat Thread")
            log.write(str(datetime.datetime.now().time())+";MQTT;Publish;Topics Published\n")
            print("Published.")
            #Subscribe to Topics
            print("Suscribing to Topics...")
            log.write(str(datetime.datetime.now().time())+";MQTT;Subscribe;Subscribing To Topics\n")
            client.subscribe("USS/TS/#",1)
            client.subscribe("USS/SS/CtrlCan/#",1)
            log.write(str(datetime.datetime.now().time())+";MQTT;Subscribe;Subscribed to: USS/TS/#\n")
            print("Suscribed...")
            state["mqtt"] = "Started"
        except:
            print("Could not connect MQTT")
            log.write(str(datetime.datetime.now().time())+";MQTT;State;Broker Connection Failed\n")
        #-----------------------      
        log.write(str(datetime.datetime.now().time())+";MQTT;Subscribe;Topics subscribed\n")
        log.close()
        #-----------------------
    
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
            #
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

      
        
        
        
        
        
        
        
        
        
        
        
        
        