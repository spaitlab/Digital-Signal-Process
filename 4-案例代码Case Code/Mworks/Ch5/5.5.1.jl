using TyPlot 
using TySignalProcessing
#指标
T = 1
fs = 1
Wp = 0.2*pi
Ws = 0.3*pi
Ap = 1
As = 15
#模拟原型滤波器
N,Wc = buttord(Wp,Ws,Ap,As,"s")
z,p,k = buttap(N)
num,den= zp2tf(z,p,k)

#数字滤波器
B,A= butter(N,Wc,"s";otype ="ba")
D,C= impinvar(B,A,fs)
W = range(0,pi,length = 512)
H,= freqz(D,C,W)
mag = abs.(H)
dbmag = 20*log10.(mag)
phase = angle.(H)
degphase = phase*180/pi; 
# 设置横坐标刻度，以0.1π为单位
subplot(3,1,1), plot(W/π, abs.(H))
 ylabel("Magnitude"), xlim(0, π),title("数字滤波器 频率-幅度")
subplot(3,1,2), plot(W/π, dbmag)
 ylabel("Magnitude(dB)"), xlim(0, π)
subplot(3,1,3), plot(W/π, degphase)
 ylabel("Magnitude(degree)"), xlim(0, π),xlabel("Frequency(0-pi)")