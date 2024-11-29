# 布拉克曼窗
using TyPlot 
using TySignalProcessing
L = 64
plot(blackman(L))
title("Time domain")
xlabel("Samples")
grid()
ylabel("Amplitude")