clc;
clear;
a0=-2;
a1=1;
a2=2;
a3=-2;
f = linspace(-200,200,200);%define spectrum
figure;
%all parameters like THD will appear on the graph
for n =1:4
    if n==1
        a0=-1;a1=1;a2=-1;a3=1;
    end
    if n==2
        a0=-2;a1=1;a2=2;a3=-2;
    end
    if n==3
        a0=1;a1=-3;a2=-1;a3=3;
    end
    if n==4
        a0=2;a1=-3;a2=2;a3=-2;
    end
    H = a0+a1*exp(-1j*f*2*pi)+a2*exp(-1j*f*4*pi)+a3*exp(-1j*f*6*pi);
    a  = thd(real(H),10000,3)%calculation THD
    subplot(2,4,n)
    plot(f,abs(H))
    legend(['||a0 = ',num2str(a0),'||a1 = ',num2str(a1),'||á2 = ',num2str(a2),'||a3 = ',num2str(a3),'||'])
    title(['amplitude of h' ,num2str(n), 'frequency response'])
    grid on; grid minor;
    subplot(2,4,n+4)
    plot(f,angle(H))
    grid on; grid minor;
    legend(['||a0 = ',num2str(a0),'||a1 = ',num2str(a1),'||á2 = ',num2str(a2),'||a3 = ',num2str(a3),'||'])
    title(['pahse h' ,num2str(n), 'frequency response','and thd is equal to',num2str(a)])
end
