using TyPlot 
using TySignalProcessing
# 定义参数和信号
N1 = 16
n = 0:15
x = sin.(2 * π * n / N1) + cos.(4 * π * n / N1)

N2 = 32
n2 = 0:31
x2 = vcat(x, zeros(16))   

N3 = 64
n3 = 0:63
x3 = vcat(x, zeros(48)) 

# 计算DFT
L1 = 0:15
dft_16 = fft(x)
L2 = 0:31
dft_32 = fft(x2)
L3 = 0:63
dft_64 = fft(x3)

# 计算并绘制X
nx = 0:15
K = 512
dw = 2 * π / K
k = 0:511
X = x'* exp.(1im * dw * nx* k')

subplot(4,1,1); plot(k*dw/(2*pi),abs.(X));
subplot(4,1,2); stem(L1/N1,abs.(dft_16));
subplot(4,1,3); stem(L2/32,abs.(dft_32));
subplot(4,1,4); stem(L3/64,abs.(dft_64));