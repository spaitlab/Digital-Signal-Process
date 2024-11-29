# 海明窗
using TyPlot 
using TySignalProcessing
L = 64
y = hamming(L)
plot(y)
title("Time domain")
axis([0 L 0 1.1])
grid()
ylabel("Amplitude") 