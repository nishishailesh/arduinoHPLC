#!/usr/bin/python3
import sys
import fcntl
import time
####Settings section start#####
input_tty='/dev/pts/1'
#socat -d -d pty,rawer,echo=0 pty,rawer,echo=0 #to create virtual com port for testing
#input_tty='/dev/ttyACM0'
logfile_name='hplc.log'
import logging
logging.basicConfig(filename=logfile_name,level=logging.DEBUG,format='%(asctime)s %(message)s')
import signal
import datetime
import time
import serial
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.animation as animation

def animate(dataList):
  ax.plot(dataList)                                   # Plot new data frame
    



def get_port():
  #port = serial.Serial(input_tty,baudrate=9600)
  port = serial.Serial(port=input_tty,baudrate=9600)
  return port

def my_read(port):
  return port.read(1)

def my_write(port,byte):
  return port.write(byte)

def my_plot(fr):
  global curx
  global x
  global y
  
  byte=my_read(port)
  my_read(port)
  str=byte.decode()
  print(str,end="")
  fd.write(str)
  curx=curx+1
  x=x+[curx]
  y=y+[int(str)] 
  plt.clf()
  splt.plot(x,y)
  plt.show()
  
#main loop##########################
filename=input("File name (Something useful):")
fd=open("data/"+filename,"w")
fd.write(time.strftime("%Y-%m-%d %H:%m:%S")+','+'HPLC data\n')
port=get_port()
port.reset_output_buffer()  #USB buffer may not be flushed

x = np.array([1,2,3,4] )
y=  np.array([5,3,4,6])
fig = plt.figure()
splt = fig.add_subplot(111) 
curx=1
ani = animation.FuncAnimation(fig, my_plot) 
plt.show()                                              # Keep Matplotlib plot persistent on screen until it is closed

close(fd)
port.close()
