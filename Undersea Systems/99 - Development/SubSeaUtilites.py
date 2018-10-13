'''
Created on Oct 10, 2018

@author: Braden
'''
import subprocess
import paho.mqtt.client as mqtt #import the client1
import time

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
    
    
    
def mosquittoStart(brokerAddress):
    broker_address="test.mosquitto.org/"
    print("creating new instance")
    client = mqtt.Client("P1") #create new instance
    client.on_message=mosquittoMessage #attach function to callback
    print("connecting to broker")
    client.connect("broker.hivemq.com", 1883, 60) #connect to broker
    print("broker connected")
    time.sleep(5)
    client.loop_start() #start the loop
    print("Subscribing to topic","GPS_Status")
    print("Publishing message to topic","GPS_Status")
    
    client.publish("GPS/GPS_Status","MQTT Start")
    
def mosquittoConnect(client, userdata, flags, rc):   
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("GPS/#")
    
def mosquittoPublish(topic,msg):
    client.publish("GPS/GPS_Status","MQTT Start")
    
def mosquittoMessage(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
