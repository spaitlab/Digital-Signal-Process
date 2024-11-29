using TySignalProcessing
using TyControlSystems
using TyMath
using TyPlot

#设定滤波器参数

N = 51
ord = 50

#使用fir1函数设计一个低通滤波器

b = fir1(ord, 0.5, "low", rectwin(N))

#计算频率响应

h, w = freqz(b, 1)

#计算冲激响应

I, t = impz(b, N)

#创建一个新的图形窗口

figure()

#绘制冲激响应

stem(t, I)
title("冲激响应")
ylabel("幅值")

#创建另一个图形窗口

figure()

#绘制频率响应的幅度（dB）

plot(w/pi, 20*log10.(abs.(h))) # 使用 log10. 来计算每个元素的对数
title("20*log10|He(jw)|")
xlabel("归一化频率(xπ rad/sample)")
ylabel("幅值(dB)")