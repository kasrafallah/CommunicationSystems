clc;
clear;
N = 50;
T = 4;
A = 3;
t0 = 2
w_0 = 2*pi/T;

a=zeros(1,100);%constant fourier series
for k=0:N
    f = @(t) (-A*heaviside(t - t0/2)...
        +A*heaviside(t + t0/2)).*exp(-1j*k*w_0*t);
    a(k+1) = integral(f,-T/2,T/2)/T;%integral on one period
end
t = linspace(-4,4,10000);
figure;
%plot function
fplot(@(t) (-A*heaviside(t - t0/2)+A*heaviside(t + t0/2)),'Linewidth',2);
xlim([-T T]);
ylim([-0.1*A 1.1*A]);
y=0;
%plot phragh for 4 difrent number of series
for n=1:4
    N =N-8
    for k=0:N
        if k~=0
       Y = 2*real(a(k+1))*cos(k*w_0*t);%each term from the Fourier series
        else
       Y = real(a(k+1));
        end
        y=y+Y;
    end
    subplot(2,2,n)
    if n ==1
        fplot(@(t) (-A*heaviside(t - t0/2)+A*heaviside(t + t0/2)),'Linewidth',2);
        hold on;
        plot(t,y,'g','Linewidth',2);
        legend('main func','furiern n =42')
        xlim([-3 3]);
        grid on; grid minor;
    elseif n ==2
        fplot(@(t) (-A*heaviside(t - t0/2)+A*heaviside(t + t0/2)),'Linewidth',2);
        hold on;
        plot(t,y,'r','Linewidth',2);
        legend('main func','furiern n =34')
        xlim([-3 3]);
        grid on; grid minor;
    elseif n ==3
        fplot(@(t) (-A*heaviside(t - t0/2)+A*heaviside(t + t0/2)),'Linewidth',2);
        hold on;
        plot(t,y,'b','Linewidth',2);
        legend('main func','furiern n =26')
        grid on; grid minor;
        xlim([-3 3]);
    elseif n ==4
        fplot(@(t) (-A*heaviside(t - t0/2)+A*heaviside(t + t0/2)),'Linewidth',2);
        hold on;
        plot(t,y,'c','Linewidth',2);
        legend('main func','furiern n =26')
        grid on; grid minor;
        xlim([-3 3]);
    end
    grid on; grid minor;
    y=0;  
end
        