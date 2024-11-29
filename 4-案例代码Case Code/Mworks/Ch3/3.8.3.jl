# 余弦窗
using TyPlot 
using TySignalProcessing

L = 51;
r = 1; 
w = tukeywin(L,r);

plot(w)
title("Time domain")

grid()
ylabel("Amplitude")