#!/usr/bin/Rscript
library("pracma")
#x=readline("give file name:")
#X11()
while(3==3)
{
	#data=read.csv(x)
	data=read.csv("data/current")
	data1=data[!is.na(data$value),]
	#v1=smooth.spline(data1$time,data1$value)
	#plot(v1,type="l")
	plot(data1$time,data1$value,type="l")
	Sys.sleep(1)
}

