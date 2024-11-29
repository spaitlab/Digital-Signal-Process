# 汉宁窗
using TyPlot 
using TySignalProcessing
L = 64
y = hann(L)
plot(y)
title("Time domain")
axis([0 L 0 1.1])
grid()
ylabel("Amplitude")