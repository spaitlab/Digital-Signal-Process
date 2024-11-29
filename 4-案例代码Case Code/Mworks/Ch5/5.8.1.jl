using TyPlot
using DSP

# 定义脉冲响应
h = [-3, 1, -1, -2, 5, 6, 5, -2, -1, 1, -3]
M = length(h)
n = 0:M-1

# 定义 hr_type1 函数
function hr_type1(h)
    M = length(h)
    L = div(M-1, 2)
    a = [h[L+1]; 2*h[L:-1:1]] # 1x(L+1) 列向量
    n = 0:L                  # (L+1) 行向量
    w = (0:1000) * π / 500   # 频率向量
    Hr = cos.(w .* n') * a   # I型幅度函数
    return Hr, w, a, L
end

# 调用 hr_type1 函数
Hr, w, a, L = hr_type1(h)


# 子图1：脉冲响应
figure()
stem(h)
xlabel("n")
ylabel("h(n)")
title("脉冲响应")


# 子图2：I型幅度函数
figure()
plot(w / π, Hr)
xlabel("频率单位π")
ylabel("Hr")
title("I型幅度函数")

# 子图3：a(n)系数
figure()
stem(a)
xlabel("n")
ylabel("a(n)")
title("a(n)系数")

# 子图4：零极点图
figure()
z, p, _ = tf2zpk(h, [1]) # 获取零极点
zplane(z,p)
title("零极点图")