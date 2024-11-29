using TyPlot   
using TySignalProcessing   
using TyBase   
        
N = 6   
str = [ "N=1 ", "N=2 ", "N=3 ", "N=4 ", "N=5 ", "N=6 "]   
for n = 1:N   
	z,p,k = buttap(n)   
    num,den = zp2tf(z,p,k)   
	w = range(0, 2*pi,length = 1000)      
	h = freqs(num,den,w)   
	mag = abs.(h)./abs.(h[1])   
	plot(w/pi,mag)   
    hold( "on ")   
end   
        
xlabel( "频率 ")   
ylabel( "振幅 ")   
title( "巴特沃斯滤波器振幅特性对结束N的依赖关系 ")   
legend(str[1],str[2],str[3],str[4],str[5],str[6])  