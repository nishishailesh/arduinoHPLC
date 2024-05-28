#!/usr/bin/python3
import sys
import fcntl
import time
####Settings section start#####
#input_tty='/dev/pts/4'
#socat -d -d pty,rawer,echo=0 pty,rawer,echo=0 #to create virtual com port for testing
input_tty='/dev/ttyACM0'
logfile_name='hplc.log'
import logging
logging.basicConfig(filename=logfile_name,level=logging.DEBUG,format='%(asctime)s %(message)s')
import signal
import datetime
import time
import serial

def get_port():
  #port = serial.Serial(input_tty,baudrate=9600)
  port = serial.Serial(port=input_tty,baudrate=9600)
  return port

def my_read(port):
  return port.read(1)

def my_write(port,byte):
  return port.write(byte)

#main loop##########################
filename=input("File name (Something useful):")
fd=open("data/"+filename,"wb",0)
fd.write(b'time'+b','+b'value\n')
port=get_port()
port.reset_output_buffer()	#USB buffer may not be flushed
while True:
  byte=my_read(port)
  #str=byte.decode()
  #print(str,end="")
  print(byte.decode(),end="")
  #fd.write(str)
  fd.write(byte)
  #logging.debug(byte)
close(fd)
