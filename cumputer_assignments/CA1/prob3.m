clc;
clear;
t = linspace(0,10,1000000);
%define function
x = @(t)(((cos(2*pi*47*t)+cos(2*pi*219*t)).*(cos(2*pi*47*t)+cos(2*pi*219*t))));
Energy = integral(x,0,10)/10 %integral for calculating energy
Fs = 1000;
x = ((cos(2*pi*47*t)+cos(2*pi*219*t)));
[Pxx,F] = periodogram(x,[],length(x),Fs);
figure;
plot([-1*F F],[Pxx Pxx])
xlim([-10 10])
title('PDS');
grid on ; grid minor;
%integral of PDS on spectrum remember that we use Fs for sampling
Energy_from_psd = sum(Pxx)/Fs
