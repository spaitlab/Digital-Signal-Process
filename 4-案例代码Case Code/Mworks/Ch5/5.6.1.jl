using TyPlot 
using TySignalProcessing
# 数字域指标：
T = 1
fs = 1
Wp = 0.2*pi # 数字频率
Ws = 0.3*pi # 数字频率
Ap = 1    #dB
As = 15   #dB
# 预畸：
wp = 2/T*tan(Wp/2) # 模拟角频率
ws = 2/T*tan(Ws/2) # 模拟角频率
# 求N，wp：
N,wp = cheb1ord(wp,ws,Ap,As,"s")

#设计模拟滤波器：
B,A = cheby1(N,Ap,wp,"s")
# 采用双线性变换法设计：
Dz,Cz = bilinear(B,A,fs)
# 画幅频、相频图：
W = range(0,pi,length = 512)
H, = freqz(Dz,Cz,W)
mag = abs.(H)
dbmag = 20*log10.(mag)
phase = angle.(H)
degphase = phase*180/pi
subplot(3,1,1), plot(W,abs.(H)),ylabel("Magnitude"), xlim(0, π),title("数字滤波器 频率-幅度")
subplot(3,1,2), plot(W,dbmag),ylabel("Magnitude(dB)"), xlim(0, π)
subplot(3,1,3), plot(W,degphase),ylabel("Magnitude(degree)"), xlim(0, π),xlabel("Frequency(0-pi)")