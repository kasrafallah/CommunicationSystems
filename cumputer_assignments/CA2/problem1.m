%%
%part_1
clc;
clear;
syms t;
f = exp(-2*t)*(heaviside(t)...
        -heaviside(t - 1))+exp(2*t)*(heaviside(-t)...
        -heaviside(-t - 1));
figure;
fplot(f);
ylim([0,1.1]);
title('plot function');
grid on ; grid minor;xlabel('t');ylabel('f(x)');
a = fourier(f);
figure;
fplot(a);
xlim([-100,100]);
title('plot fourier transform of function amplitud');
grid on ; grid minor;xlabel('W');ylabel('F(w)');
figure;
fplot(angle(a));
xlim([-100,100]);
ylim([0,4]);
title('plot fourier transform angle of function ');
grid on ; grid minor;xlabel('W');ylabel('F(w)');
%%
%part_3
clc;
clear;

F_s = 10 * 10^3;%assume sampling rate much higher than we calculated for more deitails
t = -5 : 1/F_s : 5;
Wc=2*pi*500;%500Hz
u = 0.5;%modulation index
Ac = 100;
num = length(t);
mean = 0;
for i = 1:num
   mean = mean+x(t(i));
end
mean = mean/F_s;
%Ac=Ac*(1+u * mean);
%u = u/(1+u*mean);


for i=1:1:num
    Y_AM(i) = Ac * (1+ u * (x( t(i))  )) * cos( Wc * t(i) );
end

fft_Y_AM = fft(Y_AM);

Y_fft_AM = fftshift( fft_Y_AM )/F_s;%fourier transform of AM mudolated

F = -F_s/2 : F_s/num : F_s/2 - F_s/num;%f axis is calculated

figure;
subplot(3,1,1)
plot(t, Y_AM,'g');
title('AM modulated signal in time');
xlabel('t');
ylabel('Y_AM(t)');
grid on; grid minor;
subplot(3,1,2)
plot(F,abs(Y_fft_AM),'b');
title('FT  Amplitude AM modulated Signal');
xlabel('f(Hz)');
ylabel(' ||F(Y_AM)||');
grid on;grid minor;
xlim([-1000,1000]);
subplot(3,1,3)
plot(F,angle(Y_fft_AM),'c');
xlabel('f(Hz)');
ylabel('phase(F(Y_AM))');
title('FT  phase AM modulated Signal');
grid on;grid minor;
xlim([-1000,1000]);

%%
%part_5
rcINV = 1.4*10^(-5);

y_demulated=push_detector(Y_AM,rcINV,F_s,50);


figure;
plot(t,(y_demulated),'r');
xlabel('t(s)');
ylabel('y_detected');
title('Signal detected by push detector');
grid on;grid minor;
ylim([0,2*Ac]);
%%
% part_7
Y_AM_ABS = abs(Y_AM);
rc=2*10^(-5);
Y_AM_ABS = LPF(Y_AM_ABS,pi/(Ac*u),Wc/(2*pi),F);
y_demulated=push_detector(Y_AM_ABS,rc,F_s,-Ac/2);


figure(5)
plot(t,y_demulated,'r');
xlabel('t(s)');
ylabel('y_detected');
title('Signal detected by "abs" push_detector ');
grid on;grid minor;
ylim([0,10]);
xlim([-2,2]);

%%
%part_8
Y_coherent = Y_AM .*(cos(Wc*t));
fft_Y_coherent = fftshift( fft (Y_coherent))/F_s;
fft_Y_coherent_lpf = LPF(fft_Y_coherent,1,10,F);
fft_Y_coherent_lpf_dcblocked = dcblock(fft_Y_coherent_lpf,F);
Y_output_coherent =ifft(ifftshift(fft_Y_coherent_lpf_dcblocked*F_s));
figure;
plot(t,Y_output_coherent/(Ac*u),'r');
grid on; grid minor;
xlabel('t');
ylabel('y_{dem3_{am}}');
title('Coherent demodulation ');
%%
%part_10
t=-5:1/F_s:5;
for i=1:num
    Y_SSB(i) = Ac *x( t(i)) * cos( Wc * t(i) );
end
fft_Y_SSB = fftshift(fft(Y_SSB));
fft_Y_SSB_FILTERLED = Bandpass(fft_Y_SSB,F,F_s,Wc/(2*pi));
Y_SSB = ifft( ifftshift(fft_Y_SSB_FILTERLED));
figure;
subplot(2,1,1);
plot(F,abs(fft_Y_SSB_FILTERLED))
grid on; grid minor;
xlabel('f');
ylabel('Yssb(F)');
title('amplitud of ssb frequency spectrum ');
subplot(2,1,2);
plot(t,(Y_SSB));
grid on; grid minor;
xlabel('t');
ylabel('Yssbz(t)');
title('SSB TIME DOMIN SIGNAL GENERATED ');
%%
%part_11
t=-5:1/F_s:5;
for i=1:num
    Y_SSB_demoulated(i) =  Y_SSB(i) .* cos( Wc .* t(i) );
end
fft_demoudulated = fftshift(fft(Y_SSB_demoulated));
fft_demoudulated_LPF = LPF(fft_demoudulated,1,Wc/(2*pi),F);
demoudolated_signal_ssb = ifft(ifftshift(fft_demoudulated_LPF));
figure;
subplot(2,1,1);
plot(F,abs(fft_demoudulated_LPF))
grid on; grid minor;
xlabel('f');
ylabel('Yssb_DEMOULATED(F)');
title('FREQUENCY SPECTRUM OF DEMOULATED SIGNAL SSB MUDOULATION');
subplot(2,1,2);
plot(t,demoudolated_signal_ssb);
grid on; grid minor;
xlabel('T(S)');
ylabel('Yssb_DEMOULATED(T)');
title('DEMOULATED SIGNAL FROM SSB MOUDULATION ');

%%

function f=x(t)
   f = exp(-2*t)*(heaviside(t)...
        -heaviside(t - 1))+exp(2*t)*(heaviside(-t)...
        -heaviside(-t - 1));
end


function push=push_detector(X,rc,F_s,initial)
m= length(X)
push(1) = initial;                              % initial capacitor voltage
for i = 2:m
    if ( X(i) >= push(i-1) )                   % diode on (charging)
        push(i) = X(i);
    else                                % diode off (discharging)
        push(i) = push(i-1)*(1 -exp((-1)/(F_s*rc)));
    end
end
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
function out = dcblock(X,F)
m = length(F);
out = zeros(1,m);
for i = 1:m
       if(abs(F(i))> 1/100000)
           out(i)=X(i);
       else
           out(i)=0;
       end
end
end
function y=Bandpass(Y,F,W,FC) 
    for i=1:1:length(F)
       if(F(i) > 0 && (F(i)-FC)> 0 && (F(i)-FC)<W )
           y(i)=Y(i);
       elseif( F(i) < 0 && (F(i)-FC)< 0 && -(F(i)-FC)<W )
           y(i)=Y(i);
       else
           y(i)=0;
       end
    end
end
    
