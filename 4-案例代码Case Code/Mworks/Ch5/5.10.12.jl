using TyPlot
using TySignalProcessing
# 设置 N 的值
N = 33

# 设置 Wc 的值
Wc = 0.5

# 计算 alpha
alpha = (N - 1) / 2

# 创建 l 数组
l = 0:(N - 1)

# 计算 wl
wl = (2 * π / N) * l
wl=transpose(wl)
# 计算 kt
kt = floor(N * Wc / 2)



 
Hrs = cat(ones(1, Int(kt + 1)), zeros(1, N - 2 * Int(kt + 1 ) ), ones( 1, Int(kt+1) ), dims=2)
#引入2个点的过渡带
Hrs[10] = 0.7;
Hrs[11] = 0.3;
Hrs[24] = 0.3;
Hrs[25] = 0.7;
Hdr = [1,1,0.7,0.3,0,0]; 
Hdr=transpose(Hdr)
wdl = [0,Wc,Wc+1/16.5,Wc+2/16.5,Wc+3/16.5,1];
wdl=transpose(wdl)

k1 = 0:floor((N-1)/2); 
k2 = floor((N-1)/2)+1:N-1;
angH = cat(-alpha * (2 * π) / N .* k1, alpha * (2 * π) / N .* (N .- k2), dims=1)
angH=transpose(angH)
H = Hrs .* exp.(1im .* angH)
h = real(ty_ifft(H,N));
H, w = freqz(h, 1, 512)
mag = abs.(H);
pha = angle.(H)
grd, w = grpdelay.(h, 1, 512)


# 创建一个 2x2 的子图布局
plot(layout=(2,2))

subplot(2,2,1)
plot(transpose(wl[1:Int(alpha+1)]/pi),transpose(Hrs[1:Int(alpha+1)]),"o",wdl,Hdr)
xlabel("Normalized Frequency (×π rad/sample)")
ylabel("Amplitude")
title("Amplitude Response")

subplot(2,2,2)
stem(l,h)
xlabel("n")
ylabel("h(n)")
title("Impulse Response")

subplot(2,2,3)
plot(w[2]./pi,mag,transpose(wl[1:Int(alpha+1)]/pi),transpose(Hrs[1:Int(alpha+1)]),"o")
xlabel("Normalized Frequency (×π rad/sample)")
ylabel("Magnitude")
title("Frequency Response")

subplot(2,2,4)
plot(w[2]./pi,20 * log10.(mag))
xlabel("Normalized Frequency (×π rad/sample)")
ylabel("Magnitude(dB)")
title("Magnitude Response in dB")