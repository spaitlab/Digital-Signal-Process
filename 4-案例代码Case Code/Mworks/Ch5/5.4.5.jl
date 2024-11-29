using TyPlot
using TyBase
using TySignalProcessing
n = 4
#巴特沃斯
z,p,k=buttap(n)
num,den = zp2tf(z,p,k)
w = range(0, pi,length = 1000)   
h,= freqs(num,den,w)
mag = abs.(h) 
plot(w/pi,mag)
hold("on")  
#切比雪夫-I
Rp = 1
n = 1
z,p,k = cheb1ap(n,Rp)  
num,den = zp2tf(z,p,k)
w = range(0, pi,length = 1000)    
h,= freqs(num,den,w)
max_h = abs(h[1])

n = 3
z,p,k= cheb1ap(n,Rp)       
num,den = zp2tf(z,p,k)     
w = range(0, pi,length = 1000)      
h,= freqs(num,den,w)
mag = abs.(h)/max_h
plot(w/pi,mag)

xlabel("频率")
ylabel("振幅")
title("巴特沃斯/切比雪夫-I 滤波器振幅特性对阶次N的依赖关系")
legend("N=4 巴特沃斯","N=4 切比雪夫-I")