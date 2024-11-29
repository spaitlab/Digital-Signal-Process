using TyPlot
using FFTW  # FFTW 库

function freqz_m(b, a)
    # 修改版的 freqz 子程序
    # b = H(z) 的分子多项式
    # a = H(z) 的分母多项式（对于 FIR，a = [1]）

    H, w = freqz(b, a, 1000, "whole")
    H = H[1:501]
    w = w[1:501]
    
    mag = abs.(H)
    db_result = 20 * log10.(mag .+ eps(Float64)) .- 20 * log10.(maximum(mag))  # 使用 db_result 避免冲突
    pha = angle.(H)
    
    # 对于 FIR 滤波器，可以直接计算群时延
    if a == [1]  # 检查是否为 FIR 滤波器
        grd = grpdelay(b, a, plotfig=false)  # 只传递 FIR 系数
    else
        # 对于 IIR 滤波器，使用 SOS 格式传递
        # (在这种情况下，可能需要修改你的滤波器设计为 SOS 格式)
        grd = nothing
    end

    return db_result, mag, pha, grd, w
end

# Type-1 LP FIR 滤波器的幅度响应函数
function hr_type1(h)
    N = length(h)
    ω = range(0, stop=π, length=512)
    Hr = [abs(sum(h .* exp.(-1im * ω * n) for (n, h) in enumerate(h))) for ω in ω]
    return Hr, ω
end


# 参数定义
N = 33
Wc = 0.5
alpha = (N - 1) ÷ 2
l = 0:N-1
wl = (2 * π / N) * l
kt = floor(Int, N * Wc / 2)

# 计算频率响应 Hrs 和角度 angH
Hrs = vcat(ones(Int, kt + 1), zeros(Int, N - 2 * kt - 1), ones(Int, kt))
Hdr = [1, 1, 0, 0]
wdl = [0, Wc, Wc, 1]
k1 = 0:floor(Int, (N - 1) ÷ 2)
k2 = floor(Int, (N - 1) ÷ 2) + 1:N - 1

angH = vcat(-alpha * (2 * π) / N * collect(k1), alpha * (2 * π) / N * collect(N .- k2))

# 计算 H
H = Hrs .* exp.(1im * angH)  # 使用 exp 对每个角度值进行计算

# 确保 H 是一个复数列向量并补零，使其长度为 N
H = H[1:N]  # 确保 H 的长度为 N

# 使用 FFTW 的 ifft 进行逆傅里叶变换
h = real(FFTW.ifft(H))  # 执行傅里叶逆变换

# 计算频率响应
db_values, mag, pha, grd, w = freqz_m(h, 1)

# 滤波器响应
Hr, ww = hr_type1(h)

# 使用 TyPlot 进行绘图
TyPlot.subplot(2, 2, 1)
plot(wl[1:alpha+1] / π, Hrs[1:alpha+1], "o" ,wdl,Hdr,label="Hrs")

TyPlot.subplot(2, 2, 2)
TyPlot.stem(l, h, label="Impulse Response")

TyPlot.subplot(2, 2, 3)
TyPlot.plot(ww ./ π, Hr, label="Hr")
TyPlot.plot(wl[1:alpha+1] ./ π, Hrs[1:alpha+1], marker="o", label="Hrs")

TyPlot.subplot(2, 2, 4)
TyPlot.plot(w ./ π, db_values)  # 使用 db_result 变量
TyPlot.xlabel("Frequency (π)")
TyPlot.ylabel("dB")
