clc
clear
close all
%Part3.1

R = 1;
C = 1;
W_b = 5;
f=-50:0.01:50;
for i=1:1:length(f) %Frequency Response
    if abs(f(i)) <= W_b
        h(i) = 1*((1j)*2*pi*f(i)*R*C)/(1+(1j)*2*pi*f(i)*R*C);
    elseif abs(f(i)) == W_b
         h(i) = 1/2*((1j)*2*pi*f(i)*R*C)/(1+(1j)*2*pi*f(i)*R*C);
    else
        h(i) = 0;
    end
end
%plot on onr figure phase and amplitude
figure;
plot(f,abs(h),'r');
xlabel('F(Hz)');
hold on;
plot(f,angle(h),'b--.');
xlabel('F(Hz)');
ylabel('\angle H(f)&|H(f)|');
title('amplitude & Phase frequency Response');
grid on;
grid minor;
legend('|H(f)|',"<)(H(f))");

%Part3.2
A = 1;N0 = 1e-06;fc = 5;R = 1;C = 1;
W_b=-300:0.01:300;
 %SNR respect to W
for i=1:1:length(W_b)
   snr(i)=( ( A ^ 2 ) / ( 2 * N0 ) ) * ...
       ( ( 2 * pi * fc * R * C) ^ 2 ) /...
       ( 1 + 4 * ( pi * fc * R * C ) ^ 2 ) /...
       ( W_b ( i ) - ( 1 / ( 2 * pi * R * C ) ) * ...
       atan ( 2 * pi * R * C * W_b ( i ) ) );
end
%plot snr
figure
subplot(2,1,1)
plot(W_b,snr,'b');
xlabel('W(Hz)');xlim([-0.5,+0.5]);
ylabel('SNR(w)');
title('SNR ferequency domin ');
grid on;
grid minor;
subplot(2,1,2)
plot(W_b,10*log10(snr),'r');
xlabel('W(Hz)');xlim([-10,+10]);
ylabel('SNR(w) (dB) ');ylim([30,120]);
title('logaritmic scale SNR ferequency domin');
grid on;
grid minor;


