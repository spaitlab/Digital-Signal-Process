using TyPlot
using TyBase
using TySignalProcessing
using TyMath

n = 3
Wn = 1
b, a = butter(n, Wn, "s")
poles = roots(a)
figure(1)
plot(real(poles), imag(poles), "rx", markersize=10)
hold("on")

theta = range(0, 2*pi,length = 1000)  
plot(cos.(theta), sin.(theta), "b","--")

title("Pole-Zero Plot of a 3rd-Order Butterworth Analog Filter")
xlabel("Real Axis") 
ylabel("Imaginary Axis")
grid("on", "minor")
axis("equal")