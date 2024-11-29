using TyPlot
using DSP

# 定义脉冲响应
h = [1, 2, -1, 3, 4, 4, 3, -1, 2, 1]
M = length(h)
n = 0:M-1

# 定义 hr_type2 函数
function hr_type2(h)
    M = length(h)
    L = div(M, 2) # 计算 L
    b = 2 * h[L:-1:1] # 系数向量 b
    n = (1:L) .- 0.5 # n = [1, 2, ..., L] - 0.5
    w = (0:1000) * π / 500 # 频率向量
    Hr = cos.(w .* n') * b # II 型幅度函数
    return Hr, w, b, L
end

# 调用 hr_type2 函数
Hr, w, b, L = hr_type2(h)


# 图1：脉冲响应
figure()
stem(h)
xlabel("n")
ylabel("h(n)")
title("脉冲响应")


# 图2：I型幅度函数
figure()
plot(w / π, Hr)
xlabel("频率单位π")
ylabel("Hr")
title("I型幅度函数")

# 图3：b(n)系数
figure()
stem(b)
xlabel("n")
ylabel("b(n)")
title("b(n)系数")

# 图4：零极点图
figure()
z, p, _ = tf2zpk(h, [1]) # 获取零极点
zplane(z,p)
title("零极点图")