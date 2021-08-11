%part_a
clc;
clear;
%define func
f=@(t)  ((t+2).*(heaviside(t+2)-heaviside(t))+...
    2.*(heaviside(t)-heaviside(t-1))+...
    (2+2*cos(1./2*pi.*t)).*(heaviside(t-1)-heaviside(t-3))...
    +2.*(heaviside(t-3)-heaviside(t-4)));
fs=1000;
T=1/fs;
t=-100:T:100;
x=f(t);
subplot(2,2,1);
plot(t,x)
title('x(t)')
xlim([-5,5])
grid on; grid minor;
l=length(t);
n=2^nextpow2(l);
%fft calculation
y=(fft(x,n)/l);
p=zeros(1,n);
for i=n/2+1:n
    p(i-n/2)=y(i);
    p(i)=y(i-n/2);
end
f=linspace(-fs/2,fs/2,n);
subplot(2,2,2);
plot(f,abs(p))
title('FFT OF X(T)');
grid on; grid minor;
xlim([-2 2])
%filter input signal
for i=n/2-1000:n/2+1000
    if f(i)>1.5
        p(i)=0;
    end
    if f(i)<-1.5
        p(i)=0;
    end
end
subplot(2,2,3);
plot(f,abs(p))
xlim([-2 2])
title('FFT OF X(T) passed LPF');
grid on; grid minor;
q=zeros(1,n);
for i=n/2+1:n
    q(i-n/2)=p(i);
    q(i)=p(i-n/2);
end
t=-100:T:100-T;
x=(2+t).*(t<0 & t>-2)+2.*(t>=0 & t<1)+2*(1-sin(pi/2*(t-1))).*(t>=1 & t<3)+2.*(t>=3 & t<4)+(82-20*t).*(t>=4 & t<4.1);
l=length(t);
n=l;
y=(fft(x)/l);
f=linspace(-fs/2,fs/2,n);
p=zeros(1,n);
for i=n/2+1:n
    p(i-n/2)=y(i);
    p(i)=y(i-n/2);
end
for i=n/2-1000:n/2+1000
    if f(i)>1.5
        p(i)=0;
    end
    if f(i)<-1.5
        p(i)=0;
    end
end
subplot(2,2,4);
plot(t,l*ifft(y))
xlim([-4 4])

q=zeros(1,n);
for i=n/2+1:n
    q(i-n/2)=p(i);
    q(i)=p(i-n/2);
end
hold on;
plot(t,abs(ifft(q))*l)
title(' X(T) passed LPF');
grid on; grid minor;
xlim([-4 4])

%%
%part_b
clc;
clear;
% define two functions
f1=@(t) (2+t).*(t<0 & t>-2)+2.*(t>=0 & t<1)+2*(1-sin(pi/2*(t-1))).*(t>=1 & t<3)+2.*(t>=3 & t<4)+(82-20*t).*(t>=4 & t<4.1);
f2=@(t)  t.*(t>=0 & t<1)+(t>=1 & t<2);
fs=1000;
T=1/fs;
t=-100:T:100-T;
l=length(t)
x1=f1(t);
x2=f2(t);
figure;
subplot(2,2,1);
plot(t,x1)
hold on;
xlim([-5 8])
plot(t,x2)
title('two function_')
legend('X1','X2')
grid on; grid minor;
h=conv(x1,x2); %convolve two function
t2=-200:T:200-2*T;
subplot(2,2,2);
plot(t2,h/2000)
title('convolotion')
xlim([-5,8])
grid on; grid minor;
y=fft(x1)/l.*fft(x2)/l;%furier transform calculation
f=linspace(-fs/2,fs/2,l);

p=zeros(1,l);
for i=l/2+1:l
    p(i-l/2)=y(i);
    p(i)=y(i-l/2);
end
subplot(2,2,3);
plot(f,(p))
xlim([-1 1])
title('frequency response part B');
grid on; grid minor;
z=ifft(y)*l;
q=zeros(1,l);
for i=l/2+1:l
    q(i-l/2)=z(i);
    q(i)=z(i-l/2);
end
subplot(2,2,4);
plot(t,q);
xlim([-5,8])
hold on;
plot(t2,h/100000)
grid on; grid minor;
xlim([-5,8])