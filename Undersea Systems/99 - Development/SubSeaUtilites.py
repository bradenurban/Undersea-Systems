'''
Created on Oct 10, 2018

@author: Braden
'''
import subprocess
import paho.mqtt.client as mqtt #import the client1
import time
import datetime


def test():
    print("helloworld")    
       

        
def loadConfig(temp_filepath):
    with open(temp_filepath, 'r') as file:
        parameters = file.read().splitlines()
        
        return parameters


class SSCamera:  
    def __init__(self, logTitle):
        self.state = "Not Started"
        self.ss_Log = SSLog()
        self.logTitle = logTitle
    
    def camStart(self,W,H,FrameRate,Port):
        self.ss_Log.record(self.logTitle, "Camera","State","Starting...")
        
        str_Front = "sudo uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg"
        str_W = "--width " + str(W)
        str_H = "--height " + str(H)
        str_FrameRate = "--framerate " + str(FrameRate)
        str_Middle1 = "--server-option '"
        str_Port = "--port=9090'" + str(Port)
        str_End = "--server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'"
        
        shell_command = str_Front + str_W + str_H + str_FrameRate + str_Middle1 + str_Port + str_End
        
        try:
            subprocess.call(shell_command, shell=True)
            self.ss_Log.record(self.logTitle,"Camera","State","Started")
        except:
            self.ss_Log.record(self.logTitle,"Camera","State","Error, failed to start")
            
            
    def camEnd(self):
        self.ss_Log.record(self.logTitle,"Camera","State","Ending...")
        
        try:
            subprocess.call("sudo pkill uv4l", shell=True)
            self.ss_Log.record(self.logTitle,"Camera","State","Ended")
        except:
            self.ss_Log.record(self.logTitle,"Camera","State","Error, failed to start")

class SSLog:
    def __init__(self):
        pass

    def creatLog(self, Name):
        self.title = (Name + str(datetime.datetime.now().date()) + "-" +    \
             str(datetime.datetime.now().hour)+"_"+                         \
             str(datetime.datetime.now().minute)+"_"+                       \
             str(datetime.datetime.now().second)+".txt")
        self.StartTime = datetime.datetime.now()
        self.State = "NotStarted"
        
        log = open(self.title,"w+")
        log.write(str(datetime.datetime.now().time())+";Log;Started\n")
        log.close()
        self.State = "Started"
        return self.title

    def record(self,title,Topic, SubTopic, Message):
        log = open(title,"a")
        log.write(str(datetime.datetime.now().time()) + ";" + Topic + ";" + SubTopic + ";" + Message + "\n")
        log.close()
        
class SSMQTTClass:    
    def __init__(self, logTitle):
        self.mqttc = mqtt.Client(None)
        self.mqttc.on_message = self.mqtt_on_message
        self.mqttc.on_connect = self.mqtt_on_connect
        self.mqttc.on_publish = self.mqtt_on_publish
        self.mqttc.on_subscribe = self.mqtt_on_subscribe
        self.newMode = ""
        self.newModeFlag = 0
        self.state = "notStarted"
        self.ss_Log = SSLog()
        self.logTitle = logTitle
        
    def mqtt_on_connect(self, mqttc, obj, flags, rc):
        pass

    def mqtt_on_message(self, mqttc, obj, msg):
        
        self.newModeFlag = 0
        topic = str(msg.topic)
        message = str(msg.payload.decode("utf-8"))
        print("message recieved: " + msg.payload.decode("utf-8"))
        print("Message Topic: " + str(msg.topic))
        
        self.ss_Log.record(self.logTitle, "MQTT","Receive",topic+";"+message)
        
        if topic == "USS/TS/VC/FwdCamControl":
            if message == "CamStart":
                self.newMode = "CamStart"
                self.newModeFlag = 1
            elif message == "CamEnd":
                self.newMode = "CamEnd"
                self.newModeFlag = 1
            elif message == "LoadConfig":
                self.newMode = "LoadConfig"
                self.newModeFlag = 1    
        
        
    def mqtt_on_publish(self, mqttc, obj, mid):       
        pass
        
    def mqtt_on_subscribe(self, mqttc, obj, mid, granted_qos):
        pass

    def sendMessage(self, Topic, Message):
        self.mqttc.publish(Topic,Message)
        self.ss_Log.record(self.logTitle, "MQTT","Send",Topic + ";" + Message)
        print(Topic+": "+Message)
    
    def run(self):
        self.ss_Log.record(self.logTitle, "MQTT","State","Starting...")
        try:
            self.mqttc.connect("192.168.1.82", 1883, 60)
            self.state="Started"
            self.ss_Log.record(self.logTitle, "MQTT","State","Started")
 
        except:
            self.state="notStarted"
            self.ss_Log.record(self.logTitle, "MQTT","State","Error, failed to start")
        
        
        self.mqttc.subscribe("USS/TS/#",1)
        self.mqttc.subscribe("USS/SS/CtrlCan/#",1)
        
        self.mqttc.loop_start()
        self.state = "Started"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    