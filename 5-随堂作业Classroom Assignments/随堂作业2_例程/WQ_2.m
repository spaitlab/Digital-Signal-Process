%采样相关参数设置
N = 100;     %采样点数
Fs = 8;      %采样频率 8Hz
Ts = 1/Fs;   %采样间隔 
T = N*Ts;    %采样时长
n = -N:N; 
ts = n*Ts;   %采样时间序列

%原始信号相关参数设置
f1 = 1;       %信号1频率1Hz
f2 = 2;       %信号2频率2Hz
Tn = 0.01;    %原始信号时间间隔
Fn = 1/Tn;
Nn = N*Ts/Tn;
tn = -T:Tn:T; %原始时间序列
xa = sin(2*pi*f1*tn)+sin(2*pi*f2*tn); %原始信号
x_hat1 = sin(2*pi*f1*ts)+sin(2*pi*f2*ts); %采样信号

%内插恢复信号
x_hat1_rec = [];
for i = 1 : length(tn)
    x = tn(i);
    h = sinc((x - ts).*Fs);
    g = dot(x_hat1, h);
    x_hat1_rec = [x_hat1_rec,g];
end

subplot(3,1,1);
plot(tn,xa);xlim([-3, 3]);title('原始信号');
subplot(3,1,2);
stem(ts,x_hat1);xlim([-3, 3]);title('采样信号');
subplot(3,1,3);
plot(tn,x_hat1_rec);xlim([-3, 3]);title('恢复信号');
