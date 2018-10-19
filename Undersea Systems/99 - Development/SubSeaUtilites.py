'''
Created on Oct 10, 2018

@author: Braden
'''
import subprocess
import paho.mqtt.client as mqtt #import the client1
import time

global mode

def test():
    print("helloworld")    
       

        
def loadConfig(temp_filepath):
    with open(temp_filepath, 'r') as file:
        parameters = file.read().splitlines()
        
        
        
        
        
        
        return parameters



def camStart(W,H,FrameRate,Port):
    str_Front = "sudo uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg"
    str_W = "--width " + str(W)
    str_H = "--height " + str(H)
    str_FrameRate = "--framerate " + str(FrameRate)
    str_Middle1 = "--server-option '"
    str_Port = "--port=9090'" + str(Port)
    str_End = "--server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'"
    
    shell_command = str_Front + str_W + str_H + str_FrameRate + str_Middle1 + str_Port + str_End
    subprocess.call(shell_command, shell=True)
    
def camEnd():
    subprocess.call("sudo pkill uv4l", shell=True)
    

class SSMQTTClass:
    def __init__(self, clientid=None):
        self.mqttc = mqtt.Client(clientid)
        self.mqttc.on_message = self.mqtt_on_message
        self.mqttc.on_connect = self.mqtt_on_connect
        self.mqttc.on_publish = self.mqtt_on_publish
        self.mqttc.on_subscribe = self.mqtt_on_subscribe
        
    def mqtt_on_connect(self, mqttc, obj, flags, rc):
        print("rc: "+str(rc))


    def mqtt_on_message(self, mqttc, obj, msg):
        global mode
        mode = "test"
        print(msg.topic+" "+str(msg.qos)+" "+str(msg.payload.decode("utf-8")))
        print("mode: " + mode)
        
        
    def mqtt_on_publish(self, mqttc, obj, mid):
        print("mid: "+str(mid))
        
    def mqtt_on_subscribe(self, mqttc, obj, mid, granted_qos):
        print("Subscribed: "+str(mid)+" "+str(granted_qos))
        
    def mqtt_on_log(self, mqttc, obj, level, string):
        print(string)

    def run(self):
        self.mqttc.connect("192.168.1.82", 1883, 60)
        
        self.mqttc.publish("USS/SS/FwdCam/Command","Start Command Thread")
        self.mqttc.publish("USS/SS/FwdCam/HeartBeat","Start HeartBeat Thread")
        
        self.mqttc.subscribe("USS/TS/#",1)
        self.mqttc.subscribe("USS/SS/CtrlCan/#",1)
        self.mqttc.loop_start()
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
