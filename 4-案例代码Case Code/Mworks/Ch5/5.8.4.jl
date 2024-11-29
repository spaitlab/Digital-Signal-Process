using TySignalProcessing

using TyControlSystems

using TyMath

using TyPlot

h = [-1 1 -2 2 -3 3 -2 2 -1 1]

M = length(h)

n = 0:M-1

\# 定义 hr_type4 函数

function hr_type4(h)

  M = length(h)

  L = M ÷ 2

  d = 2 .* reverse(h[L:-1:1])

  n = (1:L) .- 0.5

  w = (0:1000)' * π / 500

  Hr = zeros(size(w))  # 初始化 Hr

  for i in 1:length(w)

    Hr[i] = sum(sin(w[i] * ni) * di for (ni, di) in zip(n, d))

  end

  return Hr, w, d, L

end

\# 调用 hr_type4 函数

Hr, w, d, L = hr_type4(h)

\# 创建子图

figure()

subplot(2,2,1)

stem(n, h)

title("脉冲响应")

xlabel("n")

ylabel("h(n)")

subplot(2,2,2)

plot(w/pi, Hr)

title("IV型幅度函数")

xlabel("频率单位pi")

ylabel("Hr")

subplot(2,2,3)

stem(1:L, d)

title("d(n)系数")

xlabel("n")

ylabel("d(n)")

subplot(2,2,4)

zplane(h, 1)

title("零极点图")