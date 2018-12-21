import serial
import time

ser = serial.Serial("/dev/ttyACM0",9600)
ser.baudrate = 9600

while True:
	while ser.in_waiting > 0:
		print("in the in_waiting function")
		read_ser=ser.readline()
		print(read_ser)
	print("not in the function")

