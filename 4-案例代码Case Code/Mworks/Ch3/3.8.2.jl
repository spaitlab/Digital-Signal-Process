# 三角窗
using TyPlot 
using TySignalProcessing
L = 51;
w = triang(L);

plot(w)
title("Time domain")

grid()
ylabel("Amplitude")