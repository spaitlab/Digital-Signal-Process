# 凯塞窗
using TyPlot 
using TySignalProcessing
L = 200
beta = 2.5
w = kaiser(L,beta)
plot(w)
title("Time domain")
axis([0 L 0 1.1])
grid()
ylabel("Amplitude")