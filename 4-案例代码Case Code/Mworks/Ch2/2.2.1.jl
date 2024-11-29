using TyPlot

# 参数设置

fs = 16  # 采样频率：16Hz
f1 = 1   # 频率1：1Hz
f2 = 2   # 频率2：2Hz
N = 16
n = range(1, step=1, stop=N)
dt = 0.001  # 仿真步长：0.001s
t = range(0, step=dt, stop=1)  # 仿真时长：1s

# 模拟信号

xt = sin.(2 * pi * f1 * t) + cos.(2 * pi * f2 * t)

# 绘制模拟信号

subplot(3, 1, 1)
plot(t, xt)
xlim([0, 1])
ylim([-2, 2])
xlabel("时间 s")
ylabel("幅值")
title("信号x(t)")

# 增加采样点，便于观察；采样频率16Hz，采样间隔1/16s

x = sin.(2 * pi * (f1 / fs) * n) + cos.(2 * pi * (f2 / fs) * n)

# 绘制采样点

subplot(3, 1, 2)
stem(n / fs, x)
xlabel("时间 s")
ylabel("幅值")

# 数字序列

subplot(3, 1, 3)
stem(n, x)
xlim([0, 16])
ylim([-2, 2])
xlabel("序列号")
ylabel("序列值")
title("序列x(n)")