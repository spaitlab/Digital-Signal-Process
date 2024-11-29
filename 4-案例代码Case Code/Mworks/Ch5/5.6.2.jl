using TyPlot
using TySignalProcessing
using TyMath
# 参数定义
T = 1
fs = 1

Wp = 0.2  # 数字频率
Ws = 0.3  # 数字频率

Ap = 1  # dB
As = 15 # dB

# 转换为模拟角频率
wp = Wp / T
ws = Ws / T
fp = wp / 2 # Hz 模拟频率
fst = ws / 2 # Hz 模拟频率

# 预畸变
wp = 2 / T * tan(Wp / 2) # 预畸模拟角频率
ws = 2 / T * tan(Ws / 2) # 预畸模拟角频率
print(wp)
print(ws)
# 求滤波器阶数 N 和截止频率 wc
N, wc = TySignalProcessing.buttord(wp, ws, Ap, As)
print(wc)
# 设计模拟原型滤波器
# b,a = butter(N, wc; otype = "ba")
# z,p,k = tf2zpk(b,a)
z,p,k = buttap(N)
# 使用双线性变换法设计数字滤波器
# b1,a1 = bilinear(b,a , fs)
zd,pd,kd = bilinear(z,p,k,fs)
b1, a1 = zp2tf(zd,pd,kd)

# 计算幅频、相频响应
W = range(0, stop=pi, length=512) # 频率范围
H, = TySignalProcessing.freqz(b1, a1, W) # 频率响应
# mag = abs.(H) / abs.(H[1])
mag = abs.(H)
dbmag = 20 * log10.(mag) 
phase = angle.(H) # 输出范围: -π ~ π
degphase = phase * 180 / pi # 转为角度

# 绘图
figure()
plot(W, abs.(H))
xlabel("Frequency (rad/sample)")
ylabel("Magnitude")
title("Magnitude Response")

figure()
plot(W, dbmag)
xlabel("Frequency (rad/sample)")
ylabel("Magnitude(dB)")
title("Magnitude Response(dB)")

figure()
plot(W, degphase)
xlabel("Frequency (rad/sample)")
ylabel("Phase (degrees)")
title("Phase Response")