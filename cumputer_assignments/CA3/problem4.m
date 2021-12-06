clc;
clear;
close all;
dt = 0.0001;
t = 0:dt:10;
x = sawtooth(t);
modulated = fmmod(x,1000,1/dt,50);
figure;
subplot(5,1,1)
plot(t,x);
xlim([0,10]);
title('input signal time domine');
grid on ; grid minor;xlabel('t');ylabel('X(t)');
subplot(5,1,2);
plot(t,modulated)
xlim([0,0.5]);
title('input signal fm modulated time domine');
grid on ; grid minor;xlabel('t');ylabel('Xfm(t)');
%limiter_block
%%
for i=1:length(modulated)
    if modulated(i)>=0
        modulated(i) = 1;
    end
     if modulated(i)<0
        modulated(i) =-1;
    end
end
subplot(5,1,3)
plot(t,modulated)
xlim([0,0.01])
title('input signal fm modulated after usintg hard limiter time domine');
grid on ; grid minor;xlabel('t');ylabel('Xhardlimiter(t)');
modulated_pulse =zeros(1,length(modulated));
i = 1;
T=7;
f=zeros(1,length(modulated));
count =0;
%PULSE GENERATIOR
while i<length(modulated)
    if i == 1
    count = count+1;
    f(i) = count/t(i);f(i+1) = count/t(i+1);f(i+2) = count/t(i+2);
    modulated_pulse(1) =1;
    modulated_pulse(2) =1;
    modulated_pulse(3) =1;
    i = i+3;
    elseif modulated(i)==1&modulated(i-1)==-1&modulated(i+1)==1
        count = count+1;
        f(i) = count/t(i);f(i+1) = count/t(i+1);f(i+2) = count/t(i+2);
        modulated_pulse(i) =1;
        modulated_pulse(i+1) =1; 
        modulated_pulse(i+2) =1;
        i = i+3;
    else
    modulated_pulse(i) =0;
     f(i) = count/t(i);
     i = i+1;
    end
end
num = length(t);
F = -(1/dt)/2 : (1/dt)/num : (1/dt)/2 - (1/dt)/num;
subplot(5,1,4)
plot(t,modulated_pulse)
xlim([0,0.01])
title('input signal fm modulated pulsr generator time domine');
grid on ; grid minor;xlabel('t');ylabel('Xpusle(t)');
fft_a = fftshift(fft(modulated_pulse));
a = LPF(fft_a,1,20,F);
subplot(5,1,5)
plot(F,abs(fft_a));
c = ifft(ifftshift(a));
plot(t,65*c-19.5)
hold on;
plot(t,x)

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