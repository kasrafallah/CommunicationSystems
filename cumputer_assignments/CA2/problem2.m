%%
%part_1
clc;
clear;
F_s = 10 * 10 ^3;
t=-4:1/F_s:4;
num = length( t );
for i=1:num
    x(i)=X( t( i) );
end
figure;
subplot(2,1,1);
plot(t,x);
title('Signal in time domin');
xlabel('X(t)');
ylabel('t');
grid on;grid minor;
temp = 0;
for i=1:num
    temp = temp + X( t(i));
    integral_x(i) = temp/F_s;
end
subplot(2,1,2)
plot(t,integral_x);
title('integral of Signal in time domin');
xlabel('X(t)');
ylabel('t');
grid on;grid minor;
%%
%part_2
Fc=200;
Kf=50;
F_s=10^4;
t=-4:1/F_s:4;
for i=1:num
   x_fm(i)=cos(2* pi * Fc * t(i) + 2 * pi * Kf * integral_x(i)); 
end

figure;
plot(t, x_fm,'r');
xlabel('t(s)');
ylabel('x_FM');
ylim([-1.7,1.7]);
title('FM Modulated Signal in yime domin');
grid on;grid minor;
%%
%part_3
fft_x = fftshift(fft(x))/F_s;
fft_FM_X = fftshift(fft(x_fm))/F_s;
F = -F_s/2 : F_s/num : F_s/2 - F_s/num;
figure;
subplot(2,1,1);
plot(F,abs(fft_x));
xlim([-300,+300])
xlabel('F(hz)');
ylabel('x(f)');
title('frequency spectrum of Signal ');
grid on;grid minor;
subplot(2,1,2);
plot(F,abs(fft_FM_X));
xlim([-300,+300])
xlabel('F(hz)');
ylabel('x_FM(f)');
title('frequency spectrum of FM Modulated Signal');
grid on;grid minor;
%%
%PART_5
drivetive_x = D(x_fm,F_s,num);
abs_drivetive_x = abs(drivetive_x);
fft_demodulated = fftshift(fft(abs_drivetive_x))/F_s;
fft_demodulated_lpf = LPF(fft_demodulated,1,100,F);
signal_demudelated = ifft(ifftshift(fft_demodulated_lpf))*10;
figure;
subplot(2,1,1);
plot(F,abs(fft_demodulated_lpf));
xlim([-20,20])
xlabel('F(hz)');
ylabel('x(f)');
title('frequency spectrum of demulated Signal ');
grid on;grid minor;
subplot(2,1,2);
plot(t,(signal_demudelated/50*(2*pi)*10-1)*4);
xlabel('t(s)');
ylabel('X(t)_demulated');
title('time domin of FM deModulated Signal');
grid on;grid minor;


%%
function Y = X(t)
Y = heaviside(t)- 3*heaviside(t - 2) ...
    +2*heaviside(t-3);
end
function y=D(x,F_s,num)

for k=2:length(x)-1
    y(k)=(x(k+1)-x(k-1))*F_s/2;
end
y(1)=y(2);
y(num)=y(num-1);
end
function lpf = LPF(X,A,W,F)
m = length(F);
lpf = zeros(1,m);
for i = 1:m
       if(abs(F(i))> W)
           lpf(i)=0;
       else
           lpf(i)=A*X(i);
       end
end
end
