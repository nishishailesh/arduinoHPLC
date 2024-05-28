library("pracma")
x=readline("give file name:")
data=read.csv(x)
#data1=data[!is.na(data$r1)  &   !is.na(data$r2),]
#data1=data[!is.na(data$r1)  &   !is.na(data$r2),]
data1=data[!is.na(data$v1)  &   !is.na(data$v2) &   !is.na(data$v3),]

#pdf("x.pdf")
par(mfrow=c(2,3))

v1=smooth.spline(data1$time,data1$v1)
v2=smooth.spline(data1$time,data1$v2)
v3=smooth.spline(data1$time,data1$v3)

plot(v1,type="l")
plot(v2,type="l")
plot(v3,type="l")

readline("press a key to see derivative:")

v1d=predict(v1,deriv=1)
v2d=predict(v2,deriv=1)
v3d=predict(v3,deriv=1)

plot(v1d,type="l")
plot(v2d,type="l")
plot(v3d,type="l")

readline("press a key to find peaks:")

peaks1=findpeaks(v1d$y)
peaks2=findpeaks(v2d$y)
peaks3=findpeaks(v3d$y)

print(peaks1)
print(peaks2)
print(peaks3)
#dev.off()
