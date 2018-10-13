

import SubSeaUtilites
import paho.mqtt.client as mqtt #import the client1
import time



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
    
    
    






x = SubSeaUtilites.loadConfig(r"C:\Users\Braden\Documents\GitHub\Undersea-Systems\Undersea Systems\99 - Development\Config Files\Config_FwdCamera.txt")
print(x)


mosquittoStart("test")
    
    
    
    
    
    
    
    
    
    
    
    
    
    

