# 高斯窗
using TyPlot
using TySignalProcessing
L = 64
w = gausswin(L)
plot(w)
title("Time domain")
axis([0 L 0 1.1])
grid()
ylabel("Amplitude")