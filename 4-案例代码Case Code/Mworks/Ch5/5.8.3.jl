using TyPlot
using DSP

# 定义脉冲响应
h = [-1, 1, -2, 2, -3, 0, 3, -2, 2, -1, 1]
M = length(h)
n = 0:M-1

# 定义 hr_type3 函数
function hr_type3(h)
    M = length(h)
    L = div(M - 1, 2)  # 计算 L
    c = 2 * h[L+1:-1:1]  # 计算 c 向量，注意逆序取元素并乘以 2
    print(c)
    n = 0:L  # 生成 n 向量
    w = (0:1000) * π / 500  # 频率向量
    Hr = sin.(w .* n') * c  # 计算幅度函数 Hr
    return Hr, w, c, L  # 返回结果
end

# 调用 hr_type3 函数
Hr, w, c, L = hr_type3(h)


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

# 图3：c(n)系数
figure()
stem(c)
xlabel("n")
ylabel("c(n)")
title("c(n)系数")

# 图4：零极点图
figure()
z, p, _ = tf2zpk(h, [1]) # 获取零极点
zplane(z,p)
title("零极点图")