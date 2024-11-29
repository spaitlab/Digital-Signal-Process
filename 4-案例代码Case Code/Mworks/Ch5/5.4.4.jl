using TyPlot
using TySymbolicMath
# 定义符号变量
@variables x
# 绘制切比雪夫I型多项式
fplot.(x -> chebyshevT([0:4...],x))
axis([0 3 -2 4])
legend([raw"$T_0(x)$",raw"$T_1(x)$",raw"$T_2(x)$",raw"$T_3(x)$",raw"$T_4(x)$"])
ylabel(raw"$T_n(x)$")
title("切比雪夫-I型 多项式")
# 显示切比雪夫I型多项式的图形
figure()
# 绘制切比雪夫I型多项式
fplot.(x -> chebyshevU([0:4...],x))
axis([0 3 -2 4])
legend([raw"$T_0(x)$",raw"$T_1(x)$",raw"$T_2(x)$",raw"$T_3(x)$",raw"$T_4(x)$"])
ylabel(raw"$T_n(x)$")
title("切比雪夫-Ⅱ型 多项式")