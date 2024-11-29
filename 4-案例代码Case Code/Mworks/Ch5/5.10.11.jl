using FFTW
using TyPlot

N = 33
Wc = 0.5
alpha = (N - 1) ÷ 2
l = 0:N-1
wl = (2 * π / N) * l
kt = floor(Int, N * Wc / 2)

# 定义 Hrs 矢量

Hrs = [ones(kt + 1); zeros(N - 2 * kt - 1); ones(kt)]

# 引入 1 个点的过渡带

Hrs = vcat(ones(Int, kt + 1), zeros(Int, N - 2 * kt - 1), ones(Int, kt))
Hdr = [1, 1, 0, 0]
wdl = [0, Wc, Wc, 1]
k1 = 0:floor(Int, (N - 1) ÷ 2)
k2 = floor(Int, (N - 1) ÷ 2) + 1:N - 1

angH = [-alpha * (2 * π) / N .* k1; alpha * (2 * π) / N .* (N .- k2)]
H = Hrs .* exp.(1im * angH)

# 计算 h

h = real(ifft(H))

# 自定义的 unwrap 函数

function unwrap(phase)
    unwrapped_phase = copy(phase)
    for i in 2:length(phase)
        delta = phase[i] - phase[i - 1]
        if delta > π
            unwrapped_phase[i:end] .-= 2π
        elseif delta < -π
            unwrapped_phase[i:end] .+= 2π
        end
    end
    return unwrapped_phase
end

# 频率响应的计算（替代 freqz_m 函数）

function freqz_response(h, ω)
    H = [sum(h .* exp.(-1im * ω * n) for (n, h) in enumerate(h)) for ω in ω]
    db_values = 20 * log10.(abs.(H) .+ eps())  # 避免对零取 log10
    mag = abs.(H)
    pha = angle.(H)
    grd = diff(unwrap(pha)) ./ diff(ω)
    return db_values, mag, pha, grd
end

ω = range(0, stop=π, length=512)
db_values, mag, pha, grd = freqz_response(h, ω)

# FIR 滤波器频率响应近似计算（替代 hr_type1 函数）

function hr_type1(h)
    N = length(h)
    ω = range(0, stop=π, length=512)
    Hr = [abs(sum(h .* exp.(-1im * ω * n) for (n, h) in enumerate(h))) for ω in ω]
    return Hr, ω
end

# 计算 FIR 滤波器频率响应近似

Hr, ww = hr_type1(h)

figure()
TyPlot.plot( wl[1:alpha+1] / π, Hrs[1:alpha+1],"o",ww / π, Hr, label="Hr")
figure()

# 使用 TyPlot 进行绘图

TyPlot.subplot(2, 2, 1)
plot(wl[1:alpha+1] / π, Hrs[1:alpha+1], "o", wdl, Hdr, label="Hrs")

TyPlot.subplot(2, 2, 2)
TyPlot.stem(l, h, label="Impulse Response")

TyPlot.subplot(2, 2, 3)
TyPlot.plot(ww ./ π, Hr, label="Hr")
TyPlot.plot( wl[1:alpha+1] / π, Hrs[1:alpha+1],"o",ww / π, Hr, label="Hr")

TyPlot.subplot(2, 2, 4)
TyPlot.plot(ω ./ π, db_values)  # 使用 db_result 变量
TyPlot.xlabel("Frequency (π)")
TyPlot.ylabel("dB")

# plot(ω ./ π, db_values, label="dB")

ylim([-60,5])

# plot(wl[1:alpha+1] / π, Hrs[1:alpha+1], label="Hrs")

# figure()

# # 创建第四个子图：绘制 dB 图

# p4 = plot(ω / π, db_values, label="dB")

figure()