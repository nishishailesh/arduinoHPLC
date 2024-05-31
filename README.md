# arduinoHPLC
Arduino and analog signal from HPLC \
Data Flow\
```
Schimadzu SPC detector Analog signal A
	|
	V
Arduino analog channel
	|
	V
Arduino script to get digital data
	|
	V
Arduino sends data to serial port, Linux, Debian
	|
	V
Python script to capture serial data and save to csv
	|
	V
Shiny R app script to display saved csv as HPLC chomatogram in real time

```
