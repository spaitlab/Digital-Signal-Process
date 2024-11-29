# 矩形窗
using TyPlot 
using TySignalProcessing
L = 51;
w = rectwin(L);

plot(w)
title("Time domain")

grid()
ylabel("Amplitude")