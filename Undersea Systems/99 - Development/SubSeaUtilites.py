'''
Created on Oct 10, 2018

@author: Braden
'''
import subprocess


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