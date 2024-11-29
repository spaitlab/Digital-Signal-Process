# 布拉克曼—哈利斯窗
using TyPlot 
using TySignalProcessing
N = 32
plot(blackmanharris(N))
title("Time domain")
xlabel("Samples")
grid()
ylabel("Amplitude")