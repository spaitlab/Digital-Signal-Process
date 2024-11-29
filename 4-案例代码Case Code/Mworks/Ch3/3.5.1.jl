u = [0, 1, 2, 1, 0]
u1 = circshift(u,2)
u2 = circshift(u,-2)
u3 = reverse(u)
u4 = circshift(reverse(u), 1)

subplot(5,1,1); stem(u); xlabel("序号"); ylabel("u");
subplot(5,1,2); stem(u1); xlabel("序号"); ylabel("u1");
subplot(5,1,3); stem(u2); xlabel("序号"); ylabel("u2");
subplot(5,1,4); stem(u3); xlabel("序号"); ylabel("u3");
subplot(5,1,5); stem(u4); xlabel("序号"); ylabel("u4");